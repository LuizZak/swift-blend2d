import re
from pathlib import Path
from typing import List, Iterable

from utils.data.swift_decls import SwiftDecl
from utils.data.swift_file import SwiftFile

DirectoryStructureEntry = tuple[list[str], str | re.Pattern | list[re.Pattern]]


class DirectoryStructureManager:
    """
    A class that is used to manage nested directory structures for generated types.
    """

    def __init__(self, base_path: Path):
        self.base_path = base_path

    def path_matchers(self) -> list[DirectoryStructureEntry]:
        return list()

    def make_declaration_files(self, decls: Iterable[SwiftDecl]) -> list[SwiftFile]:
        result: dict[Path, SwiftFile] = dict()

        for decl in decls:
            path = self.path_for_decl(decl)
            file = result.get(path, SwiftFile(path, [], []))
            file.add_decl(decl)

            result[path] = file

        return list(result.values())

    def path_for_decl(self, decl: SwiftDecl) -> Path:
        file_path = self.file_for_decl(decl)

        return file_path

    def folder_for_file(self, file_name: str) -> Path:
        def matches(
            pattern: re.Pattern | list[re.Pattern | str],
            file_name: str,
        ) -> bool:
            if isinstance(pattern, re.Pattern):
                if not pattern.match(file_name):
                    return False

                return True

            for pattern in pattern:
                if isinstance(pattern, str):
                    if pattern == file_name:
                        return True
                elif pattern.match(file_name):
                    return True

            return False

        dir_path = self.base_path
        longest_path: List[str] = []

        for (path, pattern) in self.path_matchers():
            if not matches(pattern, file_name):
                continue

            if len(path) > len(longest_path):
                longest_path = path

        for component in longest_path:
            if not component.isalnum():
                raise Exception(
                    f"Expected suggested paths to contain only alphanumeric values for file {file_name}, found {component} (full: {longest_path})"
                )

        return dir_path.joinpath(*longest_path)

    def file_for_decl(self, decl: SwiftDecl) -> Path:
        decl_name = decl.name.to_string()

        file_name = f"{decl_name}.swift"

        return self.folder_for_file(file_name).joinpath(file_name)
