from utils.data.swift_decls import (
    SwiftExtensionDecl,
    SwiftMemberDecl,
)
from pycparser import c_ast


class SwiftConformanceGenerator:
    """
    Class used to generate conformances to specific Swift protocols, along with
    any required members.
    """

    protocol_name: str

    def generate_members(
        self, decl: SwiftExtensionDecl, node: c_ast.Node
    ) -> list[SwiftMemberDecl]:
        raise NotImplementedError()

    def _field_name(self, field: c_ast.Decl) -> str | None:
        # For unions, choose the first named declaration inside.
        if isinstance(field.type, c_ast.Union):
            for union_field in field.type.decls:
                if union_name := self._field_name(union_field):
                    return union_name

        return field.name
