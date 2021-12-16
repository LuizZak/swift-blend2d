import re
from pathlib import Path
from typing import List, Iterable

from utils.data.swift_decls import SwiftDecl
from utils.data.swift_file import SwiftFile

# TODO: Allow passing path matchers as arguments instead of hard-coding it here
PATH_MATCHERS: dict[re.Pattern, list[str]] = {
    # A
    # re.compile(r'^DxAdapter.+'): ["Adapter"],
}


class DirectoryStructureManager:
    """
    A class that is used to manage nested directory structures for generated types.
    """

    def __init__(self, base_path: Path):
        self.base_path = base_path

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
        dir_path = self.base_path
        longest_path: List[str] = []

        for (p, path) in PATH_MATCHERS.items():
            if p.match(file_name):
                if len(path) > len(longest_path):
                    longest_path = path

        return dir_path.joinpath(*longest_path)

    def file_for_decl(self, decl: SwiftDecl) -> Path:
        decl_name = decl.name.to_string()

        file_name = f"{decl_name}.swift"

        return self.folder_for_file(file_name).joinpath(file_name)
