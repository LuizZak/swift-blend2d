# Requires Python 3.10

import argparse
import re
import sys

from pathlib import Path
from typing import Iterable

from pycparser import c_ast
from utils.cli.console_color import ConsoleColor
from utils.converters.base_word_capitalizer import PatternCapitalizer, WordCapitalizer
from utils.converters.default_symbol_name_formatter import DefaultSymbolNameFormatter
from utils.converters.symbol_name_formatter import SymbolNameFormatter
from utils.data.swift_decl_lookup import SwiftDeclLookup
from utils.data.swift_decls import (
    CDeclKind,
    SwiftDecl,
    SwiftExtensionDecl,
    SwiftMemberVarDecl,
)
from utils.data.swift_file import SwiftFile
from utils.directory_structure.directory_structure_manager import (
    DirectoryStructureEntry,
    DirectoryStructureManager,
)
from utils.doccomment.doccomment_block import DoccommentBlock
from utils.doccomment.doccomment_formatter import DoccommentFormatter
from utils.generator.known_conformance_generators import get_conformance_generator
from utils.generator.swift_decl_generator import SwiftDeclGenerator
from utils.generator.symbol_generator_filter import SymbolGeneratorFilter
from utils.generator.symbol_name_generator import SymbolNameGenerator
from utils.data.compound_symbol_name import ComponentCase, CompoundSymbolName

from utils.generator.type_generator import (
    DeclGeneratorTarget,
    DeclFileGeneratorStdoutTarget,
    DeclFileGeneratorDiskTarget,
    TypeGeneratorRequest,
    generate_types,
)
from utils.paths import paths

FILE_NAME = "blend2d.h"

BLEND2D_PREFIXES = [
    "BL",
]
"""
List of prefixes from Blend2D declarations to convert

Will also be used as a list of terms to remove the prefix of in final declaration names.
"""

STRUCT_CONFORMANCES: list[tuple[str, list[str]]] = [
    #
    ("BLBitSetSegment", ["Equatable"]),
    ("BLRange", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Color
    ("BLRgba", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRgba32", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRgba64", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Font
    ("BLFontFaceInfo", ["Equatable", "CustomStringConvertible"]),
    ("BLFontFeatureItem", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLFontMatrix", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLFontQueryProperties", ["Equatable", "CustomStringConvertible"]),
    ("BLFontVariationItem", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Geometry
    ("BLArc", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLBox", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLBoxI", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLCircle", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLEllipse", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLLine", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLPoint", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLPointI", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRect", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRectI", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRoundRect", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLSize", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLSizeI", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLTriangle", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLMatrix2D", ["Equatable", "Hashable"]),
    # Glyph
    ("BLGlyphInfo", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLGlyphPlacement", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Gradient
    ("BLGradientStop", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLLinearGradientValues", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLRadialGradientValues", ["Equatable", "Hashable", "CustomStringConvertible"]),
    ("BLConicGradientValues", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Image
    ("BLImageInfo", ["Equatable", "Hashable", "CustomStringConvertible"]),
    # Text
    ("BLTextMetrics", ["Equatable", "Hashable", "CustomStringConvertible"]),
]
"""
List of pattern matching to apply to C struct declarations along with a list of
conformances that should be appended, in case the struct matches the pattern.
"""


class Blend2DDeclGenerator(SwiftDeclGenerator):
    # Lists declarations that where parsed and matched with an entry in STRUCT_CONFORMANCES.
    foundDecls: list[str] = []

    def generate_enum(self, node: c_ast.Enum) -> SwiftExtensionDecl | None:
        decl = super().generate_enum(node)
        if decl is None:
            return decl

        # Append 'OptionSet' conformance to some enum declarations
        if (
            decl.name.endswith("Flags")
            or decl.name.to_string() == "BLRuntimeCpuFeatures"
            or decl.name.to_string() == "BLImageCodecFeatures"
        ):
            decl.conformances.append("OptionSet")

        return decl

    def generate_struct(self, node: c_ast.Struct) -> SwiftExtensionDecl | None:
        decl = super().generate_struct(node)

        if conformances := self.propose_conformances(decl):
            decl.conformances.extend(conformances)

        return decl
    
    def propose_conformances(self, decl: SwiftExtensionDecl) -> list[str] | None:
        result = []
        
        # Match required protocols
        for req in STRUCT_CONFORMANCES:
            c_name = decl.original_name.to_string()
            if req[0] != c_name:
                continue
            
            self.foundDecls.append(c_name)

            result.extend(req[1])
        
        return list(set(result))
    
    def post_merge(self, decls: list[SwiftDecl]) -> list[SwiftDecl]:
        result = super().post_merge(decls)

        # Use proposed conformances to generate required members
        for decl in decls:
            if not isinstance(decl, SwiftExtensionDecl):
                continue
            if not isinstance(decl.original_node, c_ast.Struct):
                continue

            for conformance in sorted(decl.conformances):
                if gen := get_conformance_generator(conformance):
                    decl.members.extend(
                        gen.generate_members(decl, decl.original_node)
                    )

        return result


class Blend2DSymbolFilter(SymbolGeneratorFilter):
    def should_gen_enum_extension(
        self, node: c_ast.Enum, decl: SwiftExtensionDecl
    ) -> bool:
        if decl.c_kind == CDeclKind.ENUM:
            if (
                decl.name.to_string() == "BLObjectInfoBits"
                or decl.name.to_string() == "BLObjectInfoShift"
            ):
                return False

        return super().should_gen_enum_extension(node, decl)

    def should_gen_enum_var_member(
        self, node: c_ast.Enumerator, decl: SwiftMemberVarDecl
    ) -> bool:
        return (
            decl.c_kind == CDeclKind.ENUM_CASE
            and decl.name.to_string().lower().find("forceuint") == -1
        )


class Blend2DNameGenerator(SymbolNameGenerator):
    formatter: SymbolNameFormatter

    def __init__(self):
        self.formatter = DefaultSymbolNameFormatter(
            capitalizers=[
                # Scalar type specifiers in geometry names
                PatternCapitalizer(re.compile(r"rect(i|d)", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"box(i|d)$", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"polyline(i|d)$", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"polygon(i|d)$", flags=re.IGNORECASE)),
                # PNG tags
                WordCapitalizer("IHDR"),
                WordCapitalizer("IDAT"),
                WordCapitalizer("IEND"),
                WordCapitalizer("PLTE"),
                WordCapitalizer("TRNS"),
            ],
            terms_to_snake_case_after=["x86"],
        )

    def format_enum_case_name(self, name: CompoundSymbolName) -> CompoundSymbolName:
        """
        Fixes some wonky enum case name capitalizations.
        """
        name = self.formatter.format(name)
        result: list[CompoundSymbolName.Component] = name.components

        for i, comp in enumerate(result):
            if comp.string.startswith("Uint"):
                result[i] = comp.replacing_in_string("Uint", "UInt").with_string_case(
                    ComponentCase.AS_IS
                )

        return CompoundSymbolName(result)

    def generate(self, name: str) -> CompoundSymbolName:
        return CompoundSymbolName.from_pascal_case(name)

    def generate_enum_name(self, name: str) -> CompoundSymbolName:
        return self.generate(name)

    def generate_enum_case(
        self, enum_name: CompoundSymbolName, enum_original_name: str, case_name: str
    ) -> CompoundSymbolName:
        name = CompoundSymbolName.from_snake_case(case_name)

        orig_enum_name = CompoundSymbolName.from_pascal_case(enum_original_name)

        (new_name, prefix) = name.removing_common(orig_enum_name, case_sensitive=False)
        new_name = new_name.camel_cased()

        if prefix is not None:
            prefix = prefix.camel_cased()
            new_name[0].joint_to_prev = "_"

            new_name = CompoundSymbolName(
                components=prefix.components + new_name.components
            )

        return self.format_enum_case_name(new_name)

    def generate_struct_name(self, name: str) -> CompoundSymbolName:
        return self.generate(name)

    def generate_original_enum_name(self, name: str) -> CompoundSymbolName:
        return self.generate(name)

    def generate_original_enum_case(self, case_name: str) -> CompoundSymbolName:
        return self.generate(case_name)

    def generate_original_struct_name(self, name: str) -> CompoundSymbolName:
        return self.generate(name)


class Blend2DDoccommentFormatter(DoccommentFormatter):
    """
    Formats doc comments from Blend2D to be more Swifty, including renaming \
    referenced C symbol names to the converted Swift names.
    """

    def __init__(self):
        self.ref_regex = re.compile(r"\\ref (\w+(?:\(\))?)", re.IGNORECASE)
        self.backtick_regex = re.compile(r"`([^`]+)`")
        self.backtick_word_regex = re.compile(r"\w+")
        self.backtick_cpp_member_regex = re.compile(r"(\w+)::(\w+)")

    def replace_refs(self, string: str) -> str:
        return self.ref_regex.sub(
            lambda match: f"`{''.join(match.groups())}`",
            string,
        )

    def convert_refs(self, string: str, lookup: SwiftDeclLookup) -> str:
        def convert_word_match(match: re.Match[str]) -> str:
            name = match.group()
            swift_name = lookup.lookup_c_symbol(name)
            if swift_name is not None:
                return swift_name

            return name

        def convert_backtick_match(match: re.Match[str]) -> str:
            replaced = self.backtick_word_regex.sub(
                convert_word_match,
                match.group(),
            )
            # Perform C++ symbol rewriting (Type::member)
            replaced = self.backtick_cpp_member_regex.sub(
                lambda m: f"{m.group(1)}.{m.group(2)}",
                replaced
            )
            
            return replaced

        return self.backtick_regex.sub(convert_backtick_match, string)

    def format_doccomment(
        self, comment: DoccommentBlock | None, decl: SwiftDecl, lookup: SwiftDeclLookup
    ) -> DoccommentBlock | None:
        if comment is None:
            return super().format_doccomment(comment, decl, lookup)
        
        lines = comment.lines()

        # Remove '\ingroup*' lines
        lines = filter(lambda c: not c.startswith("\\ingroup"), lines)
        # Reword '\note' to '- note'
        lines = map(lambda c: c.replace("\\note", "- note:"), lines)

        # Replace "\ref <symbol>" with "`<symbol>`"
        lines = map(self.replace_refs, lines)

        # Convert C symbol references to Swift symbols
        lines = map(lambda c: self.convert_refs(c, lookup), lines)

        return super().format_doccomment(comment.with_lines(lines), decl, lookup)


class Blend2DDirectoryStructureManager(DirectoryStructureManager):
    def file_name_for_decl(self, decl: SwiftDecl) -> str:
        # For struct conformances, append a "+Ext.swift" to the suffix of the
        # filename
        if decl.c_kind == CDeclKind.STRUCT and isinstance(decl, SwiftExtensionDecl) and len(decl.conformances) > 0:
            return f"{decl.name.to_string()}+Ext.swift"

        return super().file_name_for_decl(decl)

    def make_declaration_files(self, decls: Iterable[SwiftDecl]) -> list[SwiftFile]:
        result = super().make_declaration_files(decls)
        for file in result:
            file.header_lines.append(
                f"// Generated by {Path(__file__).relative_to(paths.SOURCE_ROOT_PATH)}"
            )

        return result

    def path_matchers(self) -> list[DirectoryStructureEntry]:
        # Array of tuples containing:
        # tuple.0: An array of path components (min 1, must not have special characters);
        # tuple.1: Either a regular expression, OR a list of regular expression/exact
        #          strings that file names will be tested against.
        # Matches are made against full file names, with no directory information,
        # e.g.: "BLContext.swift", "BLFillRule.swift", "BLResultCode.swift", etc.
        return [
            # C
            (
                ["Context"],
                [
                    re.compile(r"^BLContext.+"),
                    "BLGradientQuality.swift",
                    "BLPatternQuality.swift",
                    "BLRenderingQuality.swift",
                    "BLFillRule.swift",
                    "BLClipMode.swift",
                    "BLCompOp.swift",
                    "BLFlattenMode.swift",
                ],
            ),
            # F
            (["File"], re.compile(r"^BLFile.+")),
            # G
            (
                ["Gradient"],
                [
                    re.compile(r"^BLGradient.+"),
                    "BLLinearGradientValues+Ext.swift",
                    "BLRadialGradientValues+Ext.swift",
                    "BLConicGradientValues+Ext.swift",
                ]
            ),
            (
                ["Geometry"],
                [
                    "BLGeometryDirection.swift",
                    "BLGeometryType.swift",
                    "BLArc+Ext.swift",
                    "BLBox+Ext.swift",
                    "BLBoxI+Ext.swift",
                    "BLCircle+Ext.swift",
                    "BLEllipse+Ext.swift",
                    "BLLine+Ext.swift",
                    "BLMatrix2D+Ext.swift",
                    "BLPoint+Ext.swift",
                    "BLPointI+Ext.swift",
                    "BLRect+Ext.swift",
                    "BLRectI+Ext.swift",
                    "BLRoundRect+Ext.swift",
                    "BLSize+Ext.swift",
                    "BLSizeI+Ext.swift",
                    "BLTriangle+Ext.swift",
                ],
            ),
            (
                ["Geometry", "Matrix"],
                [
                    re.compile(r"^BLMatrix.+"),
                    re.compile(r"^BLTransform.+")
                ],
            ),
            (
                ["Geometry", "Path"],
                [
                    re.compile(r"^BLPath.+"),
                    "BLHitTest.swift",
                    "BLOffsetMode.swift",
                ],
            ),
            # I
            (["Image"], re.compile(r"^BLImage.+")),
            # R
            (
                ["Runtime"],
                [
                    re.compile(r"^BLRuntime.+"),
                    "BLObjectType.swift",
                ],
            ),
            # S
            (["Stroke"], re.compile(r"^BLStroke.+")),
            # T
            (["Text"], re.compile(r"^BLText.+")),
            (
                ["Text", "Font"],
                [
                    re.compile(r"^BLFont.+"),
                    "BLOrientation.swift",
                ],
            ),
            (["Text", "Glyph"], re.compile(r"^BLGlyph.+")),
        ]


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generates .swift files for Blend2D enum and struct declarations."
    )

    parser.add_argument(
        "--stdout",
        action="store_true",
        help="Outputs files to stdout instead of file disk.",
    )
    parser.add_argument(
        "-o",
        "--output",
        dest="path",
        type=Path,
        help="Path to put generated files on",
    )

    args = parser.parse_args()

    input_path = paths.scripts_path(FILE_NAME)
    if not input_path.exists() or not input_path.is_file():
        print("Error: Expected path to an existing header file within utils\\.")
        return 1

    swift_target_path = (
        args.path
        if args.path is not None
        else paths.srcroot_path("Sources", "SwiftBlend2D", "Generated")
    )
    if not swift_target_path.exists() or not swift_target_path.is_dir():
        print(f"Error: No target directory with name '{swift_target_path}' found.")
        return 1

    destination_path = swift_target_path

    target: DeclGeneratorTarget

    if args.stdout:
        target = DeclFileGeneratorStdoutTarget()
    else:
        target = DeclFileGeneratorDiskTarget(destination_path, rm_folder=True)

    symbol_filter = Blend2DSymbolFilter()
    symbol_name_generator = Blend2DNameGenerator()
    decl_generator = Blend2DDeclGenerator(
        prefixes=BLEND2D_PREFIXES,
        symbol_filter=symbol_filter,
        symbol_name_generator=symbol_name_generator,
    )
    request = TypeGeneratorRequest(
        header_file=input_path,
        destination=destination_path,
        prefixes=BLEND2D_PREFIXES,
        target=target,
        includes=["blend2d"],
        swift_decl_generator=decl_generator,
        symbol_filter=symbol_filter,
        symbol_name_generator=symbol_name_generator,
        doccomment_formatter=Blend2DDoccommentFormatter(),
        directory_manager=Blend2DDirectoryStructureManager(destination_path),
    )

    generate_types(request)

    # Warn about entries in STRUCT_CONFORMANCES that where not matched
    expectedDecls = set(map(lambda t: t[0], STRUCT_CONFORMANCES))
    missingDecls = expectedDecls.symmetric_difference(decl_generator.foundDecls)

    for decl in missingDecls:
        print(f"{ConsoleColor.YELLOW('WARNING')}: Declaration {ConsoleColor.CYAN(decl)} listed in {ConsoleColor.CYAN('STRUCT_CONFORMANCES')} was not matched by any generated declaration!")


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(1)
