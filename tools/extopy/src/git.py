import subprocess
from pathlib import Path


def get_current_repository_root_path() -> Path:
    output = subprocess.check_output(['git', 'rev-parse', '--show-toplevel'], encoding='utf-8')
    return Path(output.strip()).resolve()


def clone(from_: Path, to_: Path) -> None:
    # TODO: fix
    assert from_.is_absolute()
    assert to_.is_absolute()

    subprocess.check_output(['git', 'clone', str(from_), str(to_)], encoding='utf-8')
    return
