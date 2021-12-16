# Utility to extract Swift-styled aliases of DirectX C types.

import sys
import os
import subprocess
import shutil
from dataclasses import dataclass

import pycparser

from pathlib import Path
from pycparser import c_ast
from contextlib import contextmanager

from utils.converters.syntax_stream import SyntaxStream
from utils.generator.swift_decl_generator import SwiftDeclGenerator
from utils.generator.symbol_generator_filter import SymbolGeneratorFilter
from utils.generator.symbol_name_generator import SymbolNameGenerator
from utils.data.swift_decls import SwiftDecl, SwiftEnumDecl
from utils.directory_structure.directory_structure_manager import DirectoryStructureManager
from utils.data.swift_file import SwiftFile
from utils.doccomment.doccomment_lookup import DoccommentLookup

# Utils
from utils.paths import paths


def run_cl(input_path: Path) -> bytes:
    cl_args = [
        "cl",
        "/E",
        "/Za",
        "/Zc:wchar_t",
        input_path,
    ]

    return subprocess.check_output(cl_args, cwd=paths.SCRIPTS_ROOT_PATH)


class SwiftDeclMerger:
    """
    Merges Swift declarations that share a name
    """
    
    def merge(self, decls: list[SwiftDecl]) -> list[SwiftDecl]:
        decl_dict: dict[str, SwiftDecl] = dict()

        for decl in decls:
            existing = decl_dict.get(decl.name)
            if existing is not None:
                match (existing, decl):
                    case SwiftEnumDecl(), SwiftEnumDecl():
                        decl_dict[decl.name] = SwiftEnumDecl(
                            name=existing.name,
                            original_name=existing.original_name,
                            cases=existing.cases + decl.cases,
                            origin=existing.origin,
                            doccomments=existing.doccomments,
                            conformances=existing.conformances + decl.conformances
                        )
                    case _:
                        raise BaseException(f"Found two symbols that share the same name but are of different types: {existing.name} (originally: {existing.original_name}) and {decl.name} (originally: {decl.original_name})")
            else:
                decl_dict[decl.name] = decl

        return list(decl_dict.values())


class DeclGeneratorTarget:
    def prepare(self):
        pass

    @contextmanager
    def create_stream(self, _: Path) -> SyntaxStream:
        raise NotImplementedError('Must be overridden by subclasses.')


class DeclFileGeneratorDiskTarget(DeclGeneratorTarget):
    def __init__(self, destination_folder: Path, rm_folder: bool = True, verbose: bool = True):
        self.destination_folder = destination_folder
        self.rm_folder = rm_folder
        self.directory_manager = DirectoryStructureManager(destination_folder)
        self.verbose = verbose

    def prepare(self):
        if self.verbose:
            print(f'Generating .swift files to {self.destination_folder}...')

        if self.rm_folder:
            shutil.rmtree(self.destination_folder)
            os.mkdir(self.destination_folder)

    @contextmanager
    def create_stream(self, path: Path) -> SyntaxStream:
        path.parent.mkdir(parents=True, exist_ok=True)

        with open(path, 'w', newline='\n') as file:
            stream = SyntaxStream(file)
            yield stream


class DeclFileGeneratorStdoutTarget(DeclGeneratorTarget):
    @contextmanager
    def create_stream(self, path: Path) -> SyntaxStream:
        stream = SyntaxStream(sys.stdout)
        yield stream


class DeclFileGenerator:
    def __init__(self, destination_folder: Path, target: DeclGeneratorTarget,
                 decls: list[SwiftDecl], includes: list[str]):

        self.destination_folder = destination_folder
        self.directory_manager = DirectoryStructureManager(destination_folder)
        self.target = target
        self.decls = decls
        self.includes = includes

    def generate_file(self, file: SwiftFile):
        with self.target.create_stream(file.path) as stream:
            file.write(stream)

    def generate(self):
        self.target.prepare()

        files = self.directory_manager.make_declaration_files(self.decls)

        for file in files:
            file.includes = self.includes
            self.generate_file(file)


# noinspection PyPep8Naming
class DeclCollectorVisitor(c_ast.NodeVisitor):
    decls: list[c_ast.Node] = []

    def __init__(self, prefixes: list[str]):
        self.prefixes = prefixes

    def should_include(self, decl_name: str) -> bool:
        for prefix in self.prefixes:
            if decl_name.startswith(prefix):
                return True

        return False

    def visit_Struct(self, node: c_ast.Struct):
        if node.name is not None and self.should_include(node.name):
            self.decls.append(node)

    def visit_Enum(self, node: c_ast.Enum):
        if node.name is not None and self.should_include(node.name):
            self.decls.append(node)


@dataclass
class TypeGeneratorRequest:
    header_file: Path
    destination: Path
    prefixes: list[str]
    target: DeclGeneratorTarget
    includes: list[str]
    swift_decl_generator: SwiftDeclGenerator | None
    symbol_filter: SymbolGeneratorFilter
    symbol_name_generator: SymbolNameGenerator


def generate_types(request: TypeGeneratorRequest) -> int:
    print('Generating header file...')

    output_file = run_cl(request.header_file)
    output_file = output_file.replace(b'\x0c', b'')

    output_path = request.header_file.with_suffix(".i")
    with open(output_path, 'wb') as f:
        f.write(output_file)

    print('Parsing generated header file...')

    ast = pycparser.parse_file(output_path, use_cpp=False)

    print('Collecting Swift type candidates...')

    visitor = DeclCollectorVisitor(prefixes=request.prefixes)
    visitor.visit(ast)

    if request.swift_decl_generator is not None:
        converter = request.swift_decl_generator
    else:
        converter = SwiftDeclGenerator(prefixes=request.prefixes, symbol_filter=request.symbol_filter, symbol_name_generator=request.symbol_name_generator)
    
    swift_decls = converter.generate_from_list(visitor.decls)

    print('Generating doc comments...')

    doccomment_lookup = DoccommentLookup()
    swift_decls = doccomment_lookup.populate_doc_comments(swift_decls)
    
    print('Merging generated Swift type declarations...')
    
    merger = SwiftDeclMerger()
    swift_decls = merger.merge(swift_decls)

    generator = DeclFileGenerator(request.destination, request.target, swift_decls, request.includes)
    generator.generate()

    print('Success!')

    return 0
