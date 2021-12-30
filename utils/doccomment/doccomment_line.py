from pathlib import Path
from dataclasses import dataclass


@dataclass(frozen=True)
class DoccommentLine:
    file: Path
    "Path for file that originally contained this doc comment."
    line: int
    "Line in `self.file` that contained this doc comment."
    column: int
    "Column in `self.file` that contained this doc comment."
    comment_contents: str
    """
    The contents of the doc comment line.
    
    May not be the same contents, if customized by a doccomment formatter.
    """
