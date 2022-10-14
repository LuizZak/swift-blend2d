from utils.data.compound_symbol_name import CompoundSymbolName
from utils.data.swift_decls import (
    CDeclKind,
    SwiftExtensionDecl,
    SwiftMemberDecl,
    SwiftMemberFunctionDecl,
)
from utils.generator.swift_conformance_generator import SwiftConformanceGenerator
from pycparser import c_ast


class SwiftHashableConformance(SwiftConformanceGenerator):
    """
    Generates 'Hashable' conformance for a struct type.

    Sample: Original C struct:

    ```c
    struct Sample {
        uint32_t field0;
        uint32_t field1;
    }
    ```

    Generated extension:

    ```swift
    extension Sample: Hashable { }

    public extension Sample {
        func hash(into hasher: inout Hasher) {
            hasher.combine(field0)
            hasher.combine(field1)
        }
    }
    ```
    """

    def __init__(self) -> None:
        self.protocol_name = "Hashable"

    def generate_members(
        self, decl: SwiftExtensionDecl, node: c_ast.Node
    ) -> list[SwiftMemberDecl]:

        if not isinstance(node, c_ast.Struct):
            return []

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
                        map(self._field_name, node.decls),
                    ),
                )
            )

        if len(hash_combines) > 0:
            body = hash_combines

        return [
            SwiftMemberFunctionDecl(
                CompoundSymbolName.from_string_list("hash"),
                original_name=None,
                origin=None,
                original_node=None,
                c_kind=CDeclKind.NONE,
                doccomments=[],
                arguments=[
                    ("into", "hasher", "inout Hasher"),
                ],
                body=body,
            )
        ]
