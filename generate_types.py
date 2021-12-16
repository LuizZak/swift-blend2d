import argparse
import re
import sys

from pathlib import Path

from pycparser import c_ast
from utils.converters.base_word_capitalizer import PatternCapitalizer
from utils.converters.default_symbol_name_formatter import DefaultSymbolNameFormatter
from utils.converters.symbol_name_formatter import SymbolNameFormatter
from utils.data.swift_decls import SwiftEnumCaseDecl, SwiftEnumDecl
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


class Blend2DDeclGenerator(SwiftDeclGenerator):
    def generate_enum(self, node: c_ast.Enum) -> SwiftEnumDecl:
        decl = super().generate_enum(node)
        if (
            decl.name.endswith("Flags")
            or decl.name.to_string() == "BLRuntimeCpuFeatures"
            or decl.name.to_string() == "BLImageCodecFeatures"
        ):
            decl.conformances.append("OptionSet")
        return decl


class Blend2DSymbolFilter(SymbolGeneratorFilter):
    def should_gen_enum_case(
        self, node: c_ast.Enumerator, decl: SwiftEnumCaseDecl
    ) -> bool:
        return decl.name.to_string().lower().find("forceuint") == -1


class Blend2DNameGenerator(SymbolNameGenerator):
    formatter: SymbolNameFormatter

    def __init__(self):
        self.formatter = DefaultSymbolNameFormatter(
            capitalizers=[
                PatternCapitalizer(re.compile(r"rect(i|d)", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"box(i|d)$", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"polyline(i|d)$", flags=re.IGNORECASE)),
                PatternCapitalizer(re.compile(r"polygon(i|d)$", flags=re.IGNORECASE)),
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


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generates .swift files for Blend2D enum declarations."
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
    request = TypeGeneratorRequest(
        header_file=input_path,
        destination=destination_path,
        prefixes=BLEND2D_PREFIXES,
        target=target,
        swift_decl_generator=Blend2DDeclGenerator(
            prefixes=BLEND2D_PREFIXES,
            symbol_filter=symbol_filter,
            symbol_name_generator=symbol_name_generator,
        ),
        symbol_filter=symbol_filter,
        symbol_name_generator=symbol_name_generator,
        includes=["blend2d"],
    )

    generate_types(request)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(1)
