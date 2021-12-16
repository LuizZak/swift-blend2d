from typing import TextIO
from contextlib import contextmanager


class SyntaxStream:
    def __init__(self, destination: TextIO):
        self.destination = destination
        self.indent_depth = 0

    def write(self, text: str):
        self.destination.write(text)

    def indent_str(self) -> str:
        return "    " * self.indent_depth

    def line(self, text: str = ""):
        self.write(f"{self.indent_str()}{text}\n")

    def indent(self):
        self.indent_depth += 1

    def unindent(self):
        self.indent_depth -= 1

    @contextmanager
    def block(self, line: str):
        self.line(line)
        self.indent()

        yield

        self.unindent()
        self.line("}")
