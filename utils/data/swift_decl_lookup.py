from utils.data.swift_decls import SwiftDecl, SwiftDeclAnyVisitor, SwiftDeclVisitResult


class SwiftDeclLookup:
    """
    Supports looking up Swift symbol names based on original C symbols.
    """

    def __init__(self, decls: list[SwiftDecl]):
        self.decls = decls

    def lookup_c_symbol(self, c_symbol: str) -> str | None:
        """
        Looks up C symbol names, returning the equivalent partially-qualified \
        Swift declaration name that represents that symbol.

        Lookups return a string that represents the module-level qualified accessor \
        for the symbol, e.g.:
        
        ```
        'A_C_ENUM' -> 'ACEnum'
        'A_C_ENUM_CASE' -> 'ACEnum.aCEnumCase'
        ```
        """

        class Visitor(SwiftDeclAnyVisitor):
            decl_stack: list[SwiftDecl]
            symbol_found: list[SwiftDecl] | None

            def __init__(self, lookup: str):
                self.decl_stack = list()
                self.symbol_found = None
                self.lookup = lookup

            def visit_any_decl(self, decl: SwiftDecl) -> SwiftDeclVisitResult:
                if self.symbol_found is not None:
                    self.decl_stack.append(decl)
                    return SwiftDeclVisitResult.SKIP_CHILDREN

                if decl.original_name.to_string().lower() == self.lookup.lower():
                    self.symbol_found = self.decl_stack + [decl]

                    self.decl_stack.append(decl)
                    return SwiftDeclVisitResult.SKIP_CHILDREN

                self.decl_stack.append(decl)
                return SwiftDeclVisitResult.VISIT_CHILDREN

            def post_any_decl(self, decl: SwiftDecl):
                self.decl_stack.pop()

        visitor = Visitor(c_symbol)

        for decl in self.decls:
            visitor.walk_decl(decl)
            if visitor.symbol_found is None or len(visitor.symbol_found) == 0:
                continue

            # Create fully-qualified member name
            fully_qualified = ".".join(
                map(lambda s: s.name.to_string(), visitor.symbol_found)
            )

            return fully_qualified

        return None
