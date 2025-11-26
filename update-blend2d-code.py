# Requires Python 3.10

import argparse
import glob
import os
import shutil
import subprocess
import sys
import stat
import re as re

from typing import Callable, List
from pathlib import Path
from os import PathLike

from utils.cli.cli_printing import print_stage_name
from utils.cli.console_color import ConsoleColor


# List of glob patterns to remove from the Blend2D/ASMJIT folders after code is
# initially cloned.
rmFilePatterns: list[str] = [
    "**/*_test.cpp",
    "**/*.natvis",
]


# -----
# Utility functions
# -----


def echo_call(bin: PathLike | str, *args: str):
    print(">", str(bin), *args)


def run(
    bin_name: str,
    *args: str,
    cwd: str | Path | None = None,
    echo: bool = True,
    silent: bool = False
):
    if echo:
        echo_call(bin_name, *args)

    if silent:
        subprocess.check_output([bin_name] + list(args), cwd=cwd)
    else:
        subprocess.check_call([bin_name] + list(args), cwd=cwd)


def git(command: str, *args: str, cwd: str | Path | None = None, echo: bool = True):
    run("git", command, *args, cwd=cwd, echo=echo)


def git_output(*args: str, cwd: str | None = None, echo: bool = True) -> str:
    if echo:
        echo_call("git", *args)

    return subprocess.check_output(["git"] + list(args), cwd=cwd).decode("UTF8")


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

BLEND2D_REPO = "https://github.com/blend2d/blend2d.git"
ASMJIT_REPO = "https://github.com/asmjit/asmjit.git"

BLEND2D_TARGET_PATH = cwd_path("Sources", "blend2d")
ASMJIT_TARGET_PATH = cwd_path("Sources", "asmjit")

TEMP_FOLDER_NAME = "temp"


def create_temporary_folder() -> Path:
    temp_path = cwd_path(TEMP_FOLDER_NAME)
    if temp_path.exists():
        git_rmtree(temp_path)

    os.mkdir(temp_path)

    return temp_path

def remove_files_with_pattern(base_folder: Path, patterns: list[str]):
    for pattern in patterns:
        for result in glob.iglob(pattern, root_dir=base_folder, recursive=True):
            rel_path = os.path.relpath(Path(base_folder, result), base_folder)
            final_path = Path(base_folder, rel_path).resolve()
            
            if not str(final_path).startswith(str(base_folder.resolve())):
                continue

            os.remove(final_path)


def clone_repo(tag_or_branch: str | None, repo: str, clone_path: str):
    if tag_or_branch is None:
        git("clone", repo, "--depth=1", clone_path)
    else:
        git("clone", repo, clone_path)
        git("checkout", tag_or_branch, cwd=clone_path)


def clone_blend2d(tag_or_branch: str | None, base_folder: Path) -> Path:
    print_stage_name("Cloning Blend2D...")

    blend2d_clone_path = str(path(base_folder, "blend2d").absolute())

    clone_repo(tag_or_branch, BLEND2D_REPO, blend2d_clone_path)
    remove_files_with_pattern(Path(blend2d_clone_path), rmFilePatterns)

    return Path(blend2d_clone_path)


def clone_asmjit(tag_or_branch: str | None, base_folder: Path) -> Path:
    print_stage_name("Cloning asmjit...")

    asmjit_clone_path = str(path(base_folder, "asmjit").absolute())

    clone_repo(tag_or_branch, ASMJIT_REPO, asmjit_clone_path)
    remove_files_with_pattern(Path(asmjit_clone_path), rmFilePatterns)

    return Path(asmjit_clone_path)


def backup_includes(from_path: Path, to_path: Path):
    if to_path.exists():
        shutil.rmtree(to_path)

    shutil.copytree(from_path, to_path)


def copy_repo_files(source_files: Path, target_path: Path):
    # Erase files and copy over
    shutil.rmtree(target_path)
    shutil.copytree(source_files, target_path)

def adjust_blend2d_include_paths(source_files: Path, base_path: Path):
    files = source_files.glob("**/*.h")

    for file in files:
        rel_file = file.relative_to(base_path)
        print(rel_file, end=" ")

        contents = file.read_text()

        regex = re.compile(r"#include <blend2d/(.+)>")

        modified_contents = regex.sub(
            lambda x:
                f'#include "{base_path.joinpath(x.group(1)).relative_to(file.parent, walk_up=True)}"',
            contents
        )

        file.write_text(modified_contents)

        print(ConsoleColor.GREEN("ok"))

def copy_blend2d_files(clone_path: Path, target_path: Path):
    print_stage_name("Copying over Blend2D files...")

    if target_path.is_dir():
        shutil.rmtree(target_path)
    os.mkdir(target_path)
    os.mkdir(target_path.joinpath("blend2d"))

    copy_repo_files(clone_path.joinpath("blend2d"), target_path.joinpath("blend2d"))

    print_stage_name("Adjusting #include declarations in Blend2D files...")

    adjust_blend2d_include_paths(target_path.joinpath("blend2d"), target_path.joinpath("blend2d"))

    # Emit include folder
    os.mkdir(target_path.joinpath("include"))
    include_file = target_path.joinpath("include").joinpath("blend2d.h")
    include_file.write_text('#include "../blend2d/blend2d.h"')
    modulemap_file = target_path.joinpath("include").joinpath("module.modulemap")
    modulemap_file.write_text(
"""module blend2d {
    header "../blend2d.h"
    export *
}
""")


def copy_asmjit_files(clone_path: Path, target_path: Path):
    print_stage_name("Copying over asmjit files...")

    if target_path.is_dir():
        shutil.rmtree(target_path)
    os.mkdir(target_path)
    os.mkdir(target_path.joinpath("asmjit"))

    copy_repo_files(clone_path.joinpath("asmjit"), target_path.joinpath("asmjit"))


def update_code(
    blend2d_tag_or_branch: str | None, asmjit_tag_or_branch: str | None, force: bool
) -> int:
    if (not force) and len(git_output("status", "--porcelain", echo=False).strip()) > 0:
        print(
            ConsoleColor.RED(
                "Current git repo's state is not committed! Please commit and try again. (override with --force)"
            )
        )
        return 1

    # Create temp path
    temp_path = create_temporary_folder()

    # Clone
    blend2d_clone_path = clone_blend2d(blend2d_tag_or_branch, temp_path)
    asmjit_clone_path = clone_asmjit(asmjit_tag_or_branch, temp_path)

    # Copy files
    copy_blend2d_files(blend2d_clone_path, BLEND2D_TARGET_PATH)
    copy_asmjit_files(asmjit_clone_path, ASMJIT_TARGET_PATH)

    print(ConsoleColor.GREEN("Success!"))

    git_status = git_output("status", "--porcelain").strip()
    if len(git_status) > 0:
        print(ConsoleColor.YELLOW("New unstaged changes:"))
        print(git_status)

    git_rmtree(temp_path)

    return 0


# -----
# Entry point
# -----


def main() -> int:
    def make_argparser() -> argparse.ArgumentParser:
        argparser = argparse.ArgumentParser()
        argparser.add_argument(
            "-b",
            "--blend2d_tag",
            type=str,
            help="A tag or branch to clone from the Blend2D repository. If not provided, defaults to latest commit of default branch.",
        )
        argparser.add_argument(
            "-a",
            "--asmjit_tag",
            type=str,
            help="A tag or branch to clone from the AsmJit repository. If not provided, defaults to latest commit of default branch.",
        )
        argparser.add_argument(
            "-f",
            "--force",
            action="store_true",
            help="Whether to ignore non-committed state of the repository. By default, the script fails if the repository has changes that are not committed to avoid conflicts and unintended changes.",
        )

        return argparser

    argparser = make_argparser()
    args = argparser.parse_args()

    return update_code(args.blend2d_tag, args.asmjit_tag, args.force)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except subprocess.CalledProcessError as err:
        sys.exit(err.returncode)
    except KeyboardInterrupt:
        sys.exit(1)
