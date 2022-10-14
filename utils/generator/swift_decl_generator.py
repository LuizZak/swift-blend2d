from pathlib import Path

from pycparser import c_ast
from utils.data.compound_symbol_name import CompoundSymbolName
from utils.data.swift_decls import (
    CDeclKind,
    SourceLocation,
    SwiftDecl,
    SwiftExtensionDecl,
    SwiftMemberFunctionDecl,
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

        return SwiftMemberVarDecl(
            self.symbol_name_generator.generate_enum_case(
                enum_name, enum_original_name, node.name
            ),
            self.symbol_name_generator.generate_original_enum_case(node.name),
            self.coord_to_location(node.coord),
            original_node=node,
            c_kind=CDeclKind.ENUM_CASE,
            doccomments=[],
            is_static=True
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
            doccomments=[],
            members=list(members),
            conformances=[],
        )

    def generate_struct(self, node: c_ast.Struct) -> SwiftExtensionDecl | None:
        struct_name = self.symbol_name_generator.generate_struct_name(node.name)

        return SwiftExtensionDecl(
            struct_name,
            self.symbol_name_generator.generate_original_enum_name(node.name),
            self.coord_to_location(node.coord),
            original_node=node,
            c_kind=CDeclKind.STRUCT,
            doccomments=[],
            members=[],
            conformances=[],
        )
    
    def generate_struct_equatable_method(self, node: c_ast.Struct) -> SwiftMemberFunctionDecl | None:
        body: list[str] = list()

        field_comparisons: list[str] = list()
        if node.decls is not None:
            field_comparisons = list(
                # Create equality expression for field
                map(
                    lambda field: f"lhs.{field} == rhs.{field}",
                    # Ignore non-nameable fields
                    filter(
                        lambda field: field is not None,
                        # Map field to names
                        map(
                            self._field_name,
                            node.decls
                        )
                    )
                )
            )
        
        if len(field_comparisons) > 0:
            body = [
                " && ".join(field_comparisons)
            ]

        return SwiftMemberFunctionDecl(
            CompoundSymbolName.from_string_list("==").adding_component(string="", suffix=" "),
            original_name=None,
            origin=None,
            original_node=None,
            c_kind=CDeclKind.NONE,
            doccomments=[],
            is_static=True,
            arguments=[
                (None, "lhs", "Self"),
                (None, "rhs", "Self"),
            ],
            return_type="Bool",
            body=body
        )

    def generate_struct_hashable_method(self, node: c_ast.Struct) -> SwiftMemberFunctionDecl | None:
        body: list[str] = list()

        hash_combines: list[str] = list()
        if node.decls is not None:
            hash_combines = list(
                # Create combine calls for field
                map(
                    lambda field: f"hasher.combine({field})",
                    # Ignore non-nameable fields
                    filter(
                        lambda field: field is not None,
                        # Map field to names
                        map(
                            self._field_name,
                            node.decls
                        )
                    )
                )
            )
        
        if len(hash_combines) > 0:
            body = hash_combines

        return SwiftMemberFunctionDecl(
            CompoundSymbolName.from_string_list("hash"),
            original_name=None,
            origin=None,
            original_node=None,
            c_kind=CDeclKind.NONE,
            doccomments=[],
            arguments=[
                ("into", "hasher", "inout Hasher"),
            ],
            body=body
        )

    def _field_name(self, field: c_ast.Decl) -> str | None:
        # For unions, choose the first named declaration inside.
        if isinstance(field.type, c_ast.Union):
            for union_field in field.type.decls:
                if union_name := self._field_name(union_field):
                    return union_name

        return field.name

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
