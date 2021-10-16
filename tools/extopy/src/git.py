import subprocess
from pathlib import Path


def get_current_repository_root_path() -> Path:
    output = subprocess.check_output(['git', 'rev-parse', '--show-toplevel'], encoding='utf-8')
    return Path(output.strip()).absolute()
