from pycparser import c_ast

from utils.data.swift_decls import (
    SwiftExtensionDecl,
    SwiftMemberDecl,
    SwiftMemberVarDecl,
)


class SymbolGeneratorFilter:
    def should_gen_extension(self, node: c_ast.Enum, decl: SwiftExtensionDecl) -> bool:
        return True

    def should_gen_member(self, node: c_ast.Enumerator, decl: SwiftMemberDecl) -> bool:
        return True

    def should_gen_var_member(
        self, node: c_ast.Enumerator, decl: SwiftMemberVarDecl
    ) -> bool:
        return self.should_gen_member(node, decl)
