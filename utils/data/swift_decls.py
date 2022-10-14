from dataclasses import dataclass
from enum import Enum
from typing import List
from pathlib import Path

from utils.converters.syntax_stream import SyntaxStream
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.converters.backticked_term import backticked_term
from utils.data.swift_decl_visit_result import SwiftDeclVisitResult
from utils.data.swift_decl_visitor import SwiftDeclVisitor


class CDeclKind(Enum):
    """
    Represents a kind of C declaration.
    """

    ENUM = 0
    "A C-style enum declaration."
    ENUM_CASE = 1
    "A C-style enum value declaration."
    STRUCT = 1
    "A C-style struct declaration."


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
    c_kind: CDeclKind
    doccomments: list[str]
    "A list of documentation comments associated with this element."

    def write(self, stream: SyntaxStream):
        for comment in self.doccomments:
            stream.line(f"/// {comment}")

    def copy(self):
        raise NotImplementedError("Must be implemented by subclasses.")

    def accept(self, visitor: SwiftDeclVisitor) -> SwiftDeclVisitResult:
        raise NotImplementedError("Must be implemented by subclasses.")

    def accept_post(self, visitor: SwiftDeclVisitor):
        raise NotImplementedError("Must be implemented by subclasses.")

    def children(self) -> list["SwiftDecl"]:
        raise NotImplementedError("Must be implemented by subclasses.")


@dataclass
class SwiftMemberDecl(SwiftDecl):
    """
    A Swift member declaration base class.
    """

    pass


@dataclass
class SwiftMemberVarDecl(SwiftMemberDecl):
    """
    A Swift variable member declaration.
    """

    def write(self, stream: SyntaxStream):
        super().write(stream)

        if self.name.to_string() != self.original_name.to_string():
            stream.line(
                f"static let {backticked_term(self.name.to_string())} = {self.original_name.to_string()}"
            )

    def copy(self):
        return SwiftMemberVarDecl(
            name=self.name,
            original_name=self.original_name,
            origin=self.origin,
            c_kind=self.c_kind,
            doccomments=self.doccomments,
        )

    def accept(self, visitor: SwiftDeclVisitor) -> SwiftDeclVisitResult:
        return visitor.visit(self)

    def accept_post(self, visitor: SwiftDeclVisitor):
        return visitor.post_visit(self)

    def children(self) -> list["SwiftDecl"]:
        return list()


@dataclass
class SwiftExtensionDecl(SwiftDecl):
    members: List[SwiftMemberDecl]
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

        if len(self.members) == 0:
            stream.line(decl + " { }")
            return

        with stream.block(decl + " {"):
            for i, member in enumerate(self.members):
                if i > 0:
                    stream.line()

                member.write(stream)

    def copy(self):
        return SwiftExtensionDecl(
            name=self.name,
            original_name=self.original_name,
            origin=self.origin,
            c_kind=self.c_kind,
            doccomments=self.doccomments,
            members=list(map(lambda c: c.copy(), self.members)),
            conformances=self.conformances,
        )

    def accept(self, visitor: SwiftDeclVisitor) -> SwiftDeclVisitResult:
        return visitor.visit(self)

    def accept_post(self, visitor: SwiftDeclVisitor):
        return visitor.post_visit(self)

    def children(self) -> list["SwiftDecl"]:
        return list(self.members)


class SwiftDeclWalker:
    def __init__(self, visitor: SwiftDeclVisitor):
        self.visitor = visitor

    def walk_decl(self, decl: SwiftDecl):
        result = decl.accept(self.visitor)

        if result == SwiftDeclVisitResult.VISIT_CHILDREN:
            for child in decl.children():
                self.walk_decl(child)

        decl.accept_post(self.visitor)
