from typing import Generator
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

    def iterate_field_names(
        self, fields: list[c_ast.Decl], max_tuple_length: int = 8
    ) -> Generator:
        for field in fields:
            if isinstance(field.type, c_ast.Union):
                for union_field in field.type.decls:
                    for f in self.iterate_field_names(union_field, max_tuple_length):
                        yield f
                    break
            # For array declarations, ensure that at most 8 tuple fields are
            # present, otherwise, emit an access for each tuple element.
            elif isinstance(field.type, c_ast.ArrayDecl):
                dims: int = 0
                if isinstance(field.type.dim, c_ast.Constant):
                    dims = int(field.type.dim.value)
                if dims > max_tuple_length:
                    for i in range(dims):
                        yield f"{field.name}.{i}"
                elif field.name is not None:
                    yield field.name
            elif isinstance(field, c_ast.ArrayDecl):
                # TODO: Reduce duplication with elif above
                if isinstance(field.type, c_ast.TypeDecl):
                    dims = 0
                    if isinstance(field.dim, c_ast.Constant):
                        dims = int(field.dim.value)
                    if dims > max_tuple_length:
                        for i in range(dims):
                            yield f"{field.type.declname}.{i}"
                    elif field.type.declname is not None:
                        yield field.type.declname
            elif field.name is not None:
                yield field.name

    def _field_name(self, field: c_ast.Decl) -> str | None:
        # For unions, choose the first named declaration inside.
        if isinstance(field.type, c_ast.Union):
            for union_field in field.type.decls:
                if union_name := self._field_name(union_field):
                    return union_name

        return field.name
