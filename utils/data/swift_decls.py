from dataclasses import dataclass
from typing import List
from pathlib import Path

from utils.converters.syntax_stream import SyntaxStream
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.constants.constants import backticked_term


@dataclass
class SourceLocation(object):
    file: Path
    line: int
    column: int | None


@dataclass
class SwiftDecl(object):
    name: CompoundSymbolName
    original_name: CompoundSymbolName
    origin: SourceLocation
    doccomments: list[str]
    "A list of documentation comments associated with this element."

    def write(self, stream: SyntaxStream):
        for comment in self.doccomments:
            stream.line(f"/// {comment}")

    def copy(self):
        raise NotImplementedError("Must be implemented by subclasses.")


@dataclass
class SwiftEnumCaseDecl(SwiftDecl):
    def write(self, stream: SyntaxStream):
        super().write(stream)

        if self.name.to_string() != self.original_name.to_string():
            stream.line(
                f"static let {backticked_term(self.name.to_string())} = {self.original_name.to_string()}"
            )

    def copy(self):
        return SwiftEnumCaseDecl(
            name=self.name,
            original_name=self.original_name,
            origin=self.origin,
            doccomments=self.doccomments,
        )


@dataclass
class SwiftEnumDecl(SwiftDecl):
    cases: List[SwiftEnumCaseDecl]
    conformances: list[str]

    def write(self, stream: SyntaxStream):
        super().write(stream)

        name = self.name.to_string()

        if name != self.original_name.to_string():
            stream.line(f"typealias {name} = {self.original_name.to_string()}")
            stream.line()

        # Emit conformances
        if len(self.conformances) > 0:
            for conformance in set(self.conformances):
                stream.line(f"extension {name}: {conformance} {{ }}")
            stream.line()

        decl = f"public extension {name}"

        if len(self.cases) == 0:
            stream.line(decl + " { }")
            return

        with stream.block(decl + " {"):
            for i, case in enumerate(self.cases):
                if i > 0:
                    stream.line()

                case.write(stream)

    def copy(self):
        return SwiftEnumDecl(
            name=self.name,
            original_name=self.original_name,
            origin=self.origin,
            doccomments=self.doccomments,
            cases=list(map(lambda c: c.copy(), self.cases)),
            conformances=self.conformances,
        )
