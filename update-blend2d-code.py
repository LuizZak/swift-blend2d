import argparse
import os
import shutil
import subprocess
import sys
import stat

from platform import system
from typing import Callable
from pathlib import Path
from os import PathLike

# -----
# Utility functions
# -----

def echo_call(bin: PathLike | str, *args: str):
    print('>', str(bin), *args)

def run(bin_name: str, *args: str, cwd: str | Path | None=None, echo: bool = True, silent: bool = False):
    if echo:
        echo_call(bin_name, *args)
    
    if silent:
        subprocess.check_output([bin_name] + list(args), cwd=cwd)
    else:
        subprocess.check_call([bin_name] + list(args), cwd=cwd)

def git(command: str, *args: str, cwd: str | Path | None=None, echo: bool = True):
    run('git', command, *args, cwd=cwd, echo=echo)

def git_output(*args: str, cwd: str | None=None, echo: bool = True) -> str:
    if echo:
        echo_call('git', *args)

    return subprocess.check_output(['git'] + list(args), cwd=cwd).decode('UTF8')

def path(root: PathLike | str, *args: PathLike | str) -> Path:
    return Path(root).joinpath(*args)

def cwd_path(*args: PathLike | str) -> Path:
    return path(Path.cwd(), *args)

# From: https://github.com/gitpython-developers/GitPython/blob/ea43defd777a9c0751fc44a9c6a622fc2dbd18a0/git/util.py#L101
# Windows has issues deleting readonly files that git creates
def git_rmtree(path: os.PathLike) -> None:
    """Remove the given recursively.
    :note: we use shutil rmtree but adjust its behaviour to see whether files that
        couldn't be deleted are read-only. Windows will not remove them in that case"""

    def onerror(func: Callable, path: os.PathLike, _) -> None:
        # Is the error an access error ?
        os.chmod(path, stat.S_IWUSR)

        try:
            func(path)  # Will scream if still not possible to delete.
        except Exception:
            raise

    return shutil.rmtree(path, False, onerror)

# ----
# Main logic
# ----

BLEND2D_REPO='https://github.com/blend2d/blend2d.git'
ASMJIT_REPO='https://github.com/asmjit/asmjit.git'

BLEND2D_TARGET_PATH=cwd_path('Sources', 'blend2d')
ASMJIT_TARGET_PATH=cwd_path('Sources', 'asmjit')

TEMP_FOLDER_NAME='temp'

def create_temporary_folder() -> Path:
    temp_path = cwd_path(TEMP_FOLDER_NAME)
    if temp_path.exists():
        git_rmtree(temp_path)
    
    os.mkdir(temp_path)
    
    return temp_path

def clone_repo(tag: str | None, repo: str, clone_path: str):
    if tag is None:
        git('clone', repo, '--depth=1', clone_path)
    else:
        git('clone', repo, clone_path)
        git('checkout', tag, cwd=clone_path)

def clone_blend2d(tag: str | None, base_folder: Path) -> Path:
    print("Cloning Blend2D...")

    blend2d_clone_path = str(path(base_folder, 'blend2d').absolute())

    clone_repo(tag, BLEND2D_REPO, blend2d_clone_path)
    
    return Path(blend2d_clone_path)

def clone_asmjit(tag: str | None, base_folder: Path) -> Path:
    print("Cloning asmjit...")
    
    asmjit_clone_path = str(path(base_folder, 'asmjit').absolute())

    clone_repo(tag, ASMJIT_REPO, asmjit_clone_path)
    
    return Path(asmjit_clone_path)

def backup_includes(from_path: Path, to_path: Path):
    if to_path.exists():
        shutil.rmtree(to_path)

    shutil.copytree(from_path, to_path)

def copy_repo_files(source_files: Path, target_path: Path):
    # Backup includes
    include_target_path=target_path.joinpath("include")
    include_backup_path=source_files.joinpath("include")
    backup_includes(include_target_path, include_backup_path)

    # Erase files and copy over
    shutil.rmtree(target_path)
    shutil.copytree(source_files, target_path)

def copy_blend2d_files(clone_path: Path, target_path: Path):
    print("Copying over Blend2D files...")

    copy_repo_files(clone_path.joinpath("src"), target_path)

def copy_asmjit_files(clone_path: Path, target_path: Path):
    print("Copying over asmjit files...")

    copy_repo_files(clone_path.joinpath("src").joinpath("asmjit"), target_path)

def fix_blend2d_build(target_path: Path):
    print("Patching blend2d/api.h...")

    api_file_path = target_path.joinpath("blend2d", "api.h")

    if not api_file_path.exists():
        print(f"Warning: Could not locate {api_file_path} to patch.")
        return
    
    search_line="  #define BL_DEFINE_ENUM(NAME) enum NAME\n"
    replace_with="  #define BL_DEFINE_ENUM(NAME) enum NAME : uint32_t\n"

    with api_file_path.open('r+') as file:
        lines = file.readlines()
        for (line_index, line) in enumerate(lines):
            if line == search_line:
                lines[line_index] = replace_with
                print(f"Found line to patch @ {api_file_path}:{line_index + 1}")
                break

        file.truncate()
        file.seek(0)
        file.writelines(lines)


def update_code(blend2d_tag: str | None, asmjit_tag: str | None, force: bool) -> int:
    if (not force) and len(git_output('status', '--porcelain', echo=False).strip()) > 0:
        print("Current git repo's state is not committed! Please commit and try again.")
        return 1
    
    # Create temp path
    temp_path = create_temporary_folder()

    # Clone
    blend2d_clone_path = clone_blend2d(blend2d_tag, temp_path)
    asmjit_clone_path = clone_asmjit(asmjit_tag, temp_path)

    # Copy files
    copy_blend2d_files(blend2d_clone_path, BLEND2D_TARGET_PATH)
    copy_asmjit_files(asmjit_clone_path, ASMJIT_TARGET_PATH)

    # Fix a known build issue located in blend2d/api.h
    fix_blend2d_build(BLEND2D_TARGET_PATH)

    print("Success!")

    git_status = git_output('status', '--porcelain').strip()
    if len(git_status) > 0:
        print('New unstaged changes:')
        print(git_status)
    
    git_rmtree(temp_path)

    return 0

# -----
# Entry point
# -----

def main() -> int:    
    def make_argparser() -> argparse.ArgumentParser:
        argparser = argparse.ArgumentParser()
        argparser.add_argument('-b', '--blend2d_tag',
                               type=str,
                               help='A tag or branch to clone from the Blend2D repository. If not provided, defaults to latest commit of default branch.')
        argparser.add_argument('-a', '--asmjit_tag',
                               type=str,
                               help='A tag or branch to clone from the AsmJit repository. If not provided, defaults to latest commit of default branch.')
        argparser.add_argument('-f', '--force',
                               action='store_true',
                               help='Whether to ignore non-commited state of the repository. By default, the script fails if the repository has changes that are not commited to avoid conflicts and unintended changes.')

        return argparser

    argparser = make_argparser()
    args = argparser.parse_args()

    return update_code(args.blend2d_tag, args.asmjit_tag, args.force)

if __name__=='__main__':
    try:
        sys.exit(main())
    except subprocess.CalledProcessError as err:
        sys.exit(err.returncode)
    except KeyboardInterrupt:
        sys.exit(1)
