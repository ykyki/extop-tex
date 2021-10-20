import subprocess
from pathlib import Path


def get_current_repository_path() -> Path:
    output = subprocess.check_output(['git', 'rev-parse', '--show-toplevel'], encoding='utf-8')
    return Path(output.strip()).resolve()


def clone(from_: Path, to_: Path) -> None:
    if not(from_.is_absolute()):
        raise ValueError(f'{from_=} should be an absolute path.')
    if not(to_.is_absolute()):
        raise ValueError(f'{to_=} should be an absolute path.')

    subprocess.check_output(['git', 'clone', str(from_), str(to_)], encoding='utf-8')
    return
