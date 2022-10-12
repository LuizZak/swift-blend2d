from pathlib import Path
from typing import Sequence

from utils.data.swift_decls import SwiftDecl, SwiftEnumDecl
from utils.doccomment.doccomment_line import DoccommentLine


class DoccommentLookup:
    cached_files: dict[Path, list[str]] = dict()
    # Note: should be sorted by length in descending order
    doccomment_patterns = [
        "//!<",
        "//!",
    ]

    def as_doc_comment_line(
        self, file: Path, line_index: int, original_line: str
    ) -> DoccommentLine | None:
        line = original_line.lstrip()
        offset = len(original_line) - len(line)

        for pattern in self.doccomment_patterns:
            if line.startswith(pattern):
                contents = line[len(pattern) :].strip()
                return DoccommentLine(file, line_index, offset + len(pattern), contents)

        return None

    def inline_doccomment(
        self, file: Path, line_index: int, original_line: str
    ) -> DoccommentLine | None:
        for pattern in self.doccomment_patterns:
            offset = original_line.find(pattern)
            if offset == -1:
                continue

            contents = original_line[offset + len(pattern) :].strip()
            return DoccommentLine(file, line_index, offset, contents)

        return None

    def contents_for_file(self, file_path: Path) -> list[str] | None:
        cached = self.cached_files.get(file_path)
        if cached is not None:
            return cached

        if not (file_path.exists() and file_path.is_file()):
            return None

        with open(file_path) as file:
            lines = file.readlines()
            self.cached_files[file_path] = lines

            return lines

    def find_doccomment(self, decl: SwiftDecl) -> list[DoccommentLine] | None:
        decl_file_path = decl.origin.file
        decl_line_num = decl.origin.line - 1

        lines = self.contents_for_file(decl_file_path)

        if lines is None or len(lines) < decl_line_num:
            return None

        # Attempt to intercept comments that are inline with the declaration
        decl_line = lines[decl_line_num]
        inline = self.inline_doccomment(decl_file_path, decl_line_num, decl_line)
        if inline is not None:
            return [inline]

        # Collect all doc comment lines that precede the definition line
        # until we reach a line that is not a doc comment, at which case
        # return the collected doc comment lines.
        collected = []
        for i in reversed(range(decl_line_num)):
            doc = self.as_doc_comment_line(decl_file_path, i, lines[i])

            if doc is None:
                break

            collected.append(doc)

        return list(reversed(collected))

    def populate_doc_comments(self, decls: Sequence[SwiftDecl]) -> list[SwiftDecl]:
        results = []

        for decl in decls:
            comments = self.find_doccomment(decl)
            if comments is None:
                continue

            copy = decl.copy()
            copy.doccomments = list(map(lambda c: c.comment_contents, comments))

            # TODO: Figure out a way to avoid this hardcoding of nested decl traversal
            if isinstance(decl, SwiftEnumDecl):
                copy.cases = list(self.populate_doc_comments(decl.cases))

            results.append(copy)

        return results
