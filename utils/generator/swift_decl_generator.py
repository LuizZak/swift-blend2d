from pathlib import Path

from pycparser import c_ast
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.data.swift_decls import (
    SourceLocation,
    SwiftDecl,
    SwiftEnumDecl,
    SwiftEnumCaseDecl,
)
from utils.generator.symbol_generator_filter import SymbolGeneratorFilter
from utils.generator.symbol_name_generator import SymbolNameGenerator


# Visitor / declaration collection


class SwiftDeclGenerator:
    def __init__(
        self,
        prefixes: list[str],
        symbol_filter: SymbolGeneratorFilter,
        symbol_name_generator: SymbolNameGenerator,
    ):
        self.prefixes = prefixes
        self.symbol_filter = symbol_filter
        self.symbol_name_generator = symbol_name_generator

    def coord_to_location(self, coord) -> SourceLocation:
        return SourceLocation(Path(coord.file), coord.line, coord.column)

    # Enum

    def generate_enum_case(
        self,
        enum_name: CompoundSymbolName,
        enum_original_name: str,
        node: c_ast.Enumerator,
    ) -> SwiftEnumCaseDecl:

        return SwiftEnumCaseDecl(
            self.symbol_name_generator.generate_enum_case(
                enum_name, enum_original_name, node.name
            ),
            self.symbol_name_generator.generate_original_enum_case(node.name),
            self.coord_to_location(node.coord),
            doccomments=[],
        )

    def generate_enum(self, node: c_ast.Enum) -> SwiftEnumDecl:
        enum_name = self.symbol_name_generator.generate_enum_name(node.name)

        cases = []
        if node.values is not None:
            for case_node in node.values:
                case_decl = self.generate_enum_case(enum_name, node.name, case_node)

                if self.symbol_filter.should_gen_enum_case(case_node, case_decl):
                    cases.append(case_decl)

        return SwiftEnumDecl(
            enum_name,
            self.symbol_name_generator.generate_original_enum_name(node.name),
            self.coord_to_location(node.coord),
            doccomments=[],
            cases=list(cases),
            conformances=[],
        )

    #

    def generate(self, node: c_ast.Node) -> SwiftDecl | None:
        if isinstance(node, c_ast.Enum):
            decl = self.generate_enum(node)
            if self.symbol_filter.should_gen_enum(node, decl):
                return decl
        # elif isinstance(node, c_ast.Struct):
        #     return self.convert_struct(node)

        return None

    def generate_from_list(self, nodes: list[c_ast.Node]) -> list[SwiftDecl]:
        result = []
        for node in nodes:
            decl = self.generate(node)
            if decl is not None:
                result.append(decl)

        return result
