from pycparser import c_ast

from utils.data.swift_decls import SwiftEnumCaseDecl, SwiftEnumDecl


class SymbolGeneratorFilter:
    def should_gen_enum(self, node: c_ast.Enum, decl: SwiftEnumDecl) -> bool:
        return True

    def should_gen_enum_case(
        self, node: c_ast.Enumerator, decl: SwiftEnumCaseDecl
    ) -> bool:
        return True
