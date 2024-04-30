from pathlib import Path

from pycparser import c_ast
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.data.swift_decls import (
    CDeclKind,
    SourceLocation,
    SwiftDecl,
    SwiftExtensionDecl,
    SwiftMemberVarDecl,
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
    ) -> SwiftMemberVarDecl | None:

        value = self.symbol_name_generator.generate_original_enum_case(node.name).to_string()

        return SwiftMemberVarDecl(
            self.symbol_name_generator.generate_enum_case(
                enum_name, enum_original_name, node.name
            ),
            self.symbol_name_generator.generate_original_enum_case(node.name),
            self.coord_to_location(node.coord),
            original_node=node,
            c_kind=CDeclKind.ENUM_CASE,
            doccomment=None,
            is_static=True,
            initial_value=value
        )

    def generate_enum(self, node: c_ast.Enum) -> SwiftExtensionDecl | None:
        enum_name = self.symbol_name_generator.generate_enum_name(node.name)

        members = []
        if node.values is not None:
            for case_node in node.values:
                case_decl = self.generate_enum_case(enum_name, node.name, case_node)
                if case_decl is None:
                    continue

                if self.symbol_filter.should_gen_enum_var_member(case_node, case_decl):
                    members.append(case_decl)

        return SwiftExtensionDecl(
            enum_name,
            self.symbol_name_generator.generate_original_enum_name(node.name),
            self.coord_to_location(node.coord),
            original_node=node,
            c_kind=CDeclKind.ENUM,
            doccomment=None,
            members=list(members),
            conformances=[],
        )

    # Struct

    def generate_struct(self, node: c_ast.Struct) -> SwiftExtensionDecl | None:
        struct_name = self.symbol_name_generator.generate_struct_name(node.name)

        return SwiftExtensionDecl(
            struct_name,
            self.symbol_name_generator.generate_original_enum_name(node.name),
            self.coord_to_location(node.coord),
            original_node=node,
            c_kind=CDeclKind.STRUCT,
            doccomment=None,
            members=[],
            conformances=[],
        )
    
    #

    def generate(self, node: c_ast.Node) -> SwiftDecl | None:
        match node:
            case c_ast.Enum():
                decl = self.generate_enum(node)
                if decl is None:
                    return None

                if self.symbol_filter.should_gen_enum_extension(node, decl):
                    return decl
            case c_ast.Struct():
                decl = self.generate_struct(node)
                if decl is None:
                    return None

                if self.symbol_filter.should_gen_struct_extension(node, decl):
                    return decl
        
        return None

    def generate_from_list(self, nodes: list[c_ast.Node]) -> list[SwiftDecl]:
        result = []
        for node in nodes:
            decl = self.generate(node)
            if decl is not None:
                result.append(decl)

        return result

    def post_merge(self, decls: list[SwiftDecl]) -> list[SwiftDecl]:
        "Applies post-type merge operations to a list of Swift declarations"

        return decls
