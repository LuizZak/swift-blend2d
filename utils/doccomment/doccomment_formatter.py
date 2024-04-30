from utils.data.swift_decl_lookup import SwiftDeclLookup
from utils.data.swift_decls import SwiftDecl


class DoccommentFormatter:
    def format_doccomments(
        self, comments: list[str], decl: SwiftDecl, decl_lookup: SwiftDeclLookup
    ) -> list[str]:
        # Trim empty lines leading and trailing doc comments
        has_content = False
        first_index: int | None = None
        last_index: int | None = None

        for (i, comment) in enumerate(comments):
            if len(comment.strip()) > 0:
                has_content = True

                if first_index is None:
                    first_index = i
                if last_index is None or last_index < i:
                    last_index = i

        if not has_content:
            return comments

        if (first_index is not None) and (last_index is not None):
            return comments[first_index : (last_index + 1)]

        return comments
