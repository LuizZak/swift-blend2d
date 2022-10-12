from dataclasses import dataclass
from enum import Enum
from typing import List
from pathlib import Path

from utils.converters.syntax_stream import SyntaxStream
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.converters.backticked_term import backticked_term


class SwiftDeclVisitResult(Enum):
    """
    Defines the behavior of a SwiftDeclVisitor as it visits declarations.
    """

    VISIT_CHILDREN = 0
    "The visitor should visit the children of a declaration."
    SKIP_CHILDREN = 1
    "The visitor should skip the children of a declaration."


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

    def accept(self, visitor: "SwiftDeclVisitor") -> SwiftDeclVisitResult:
        raise NotImplementedError("Must be implemented by subclasses.")

    def accept_post(self, visitor: "SwiftDeclVisitor"):
        raise NotImplementedError("Must be implemented by subclasses.")

    def children(self) -> list["SwiftDecl"]:
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

    def accept(self, visitor: "SwiftDeclVisitor") -> SwiftDeclVisitResult:
        return visitor.visit_enum_case_decl(self)

    def accept_post(self, visitor: "SwiftDeclVisitor"):
        return visitor.post_enum_case_decl(self)

    def children(self) -> list["SwiftDecl"]:
        return list()


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

    def accept(self, visitor: "SwiftDeclVisitor") -> SwiftDeclVisitResult:
        return visitor.visit_enum_decl(self)

    def accept_post(self, visitor: "SwiftDeclVisitor"):
        return visitor.post_enum_decl(self)

    def children(self) -> list["SwiftDecl"]:
        return list(self.cases)


class SwiftDeclVisitor:
    def visit_enum_decl(self, decl: SwiftEnumDecl) -> SwiftDeclVisitResult:
        return SwiftDeclVisitResult.VISIT_CHILDREN

    def post_enum_decl(self, decl: SwiftEnumDecl):
        pass

    def visit_enum_case_decl(self, decl: SwiftEnumCaseDecl) -> SwiftDeclVisitResult:
        return SwiftDeclVisitResult.VISIT_CHILDREN

    def post_enum_case_decl(self, decl: SwiftEnumCaseDecl):
        pass

    def walk_decl(self, decl: SwiftDecl):
        walker = SwiftDeclWalker(self)
        walker.walk_decl(decl)


class SwiftDeclAnyVisitor(SwiftDeclVisitor):
    """
    A declaration visitor that pipes all visits to `self.visit_any_decl`
    """

    def visit_any_decl(self, decl: SwiftDecl) -> SwiftDeclVisitResult:
        return SwiftDeclVisitResult.VISIT_CHILDREN

    def post_any_decl(self, decl: SwiftDecl):
        pass

    def visit_enum_decl(self, decl: SwiftEnumDecl) -> SwiftDeclVisitResult:
        return self.visit_any_decl(decl)

    def post_enum_decl(self, decl: SwiftEnumDecl):
        self.post_any_decl(decl)

    def visit_enum_case_decl(self, decl: SwiftEnumCaseDecl) -> SwiftDeclVisitResult:
        return self.visit_any_decl(decl)

    def post_enum_case_decl(self, decl: SwiftEnumCaseDecl):
        self.post_any_decl(decl)


class SwiftDeclWalker:
    def __init__(self, visitor: SwiftDeclVisitor):
        self.visitor = visitor

    def walk_decl(self, decl: SwiftDecl):
        result = decl.accept(self.visitor)

        if result == SwiftDeclVisitResult.VISIT_CHILDREN:
            for child in decl.children():
                self.walk_decl(child)

        decl.accept_post(self.visitor)
