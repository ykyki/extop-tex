from pathlib import Path
from typing import *


def get_cwd_path() -> Path:
    return Path('.').absolute()


T = TypeVar('T')


def run_in_tempdir(func: Callable[..., T]):
    def wrapper(*args, **kwargs) -> T:
        import os
        import tempfile

        initial_path = get_cwd_path()

        try:
            with tempfile.TemporaryDirectory() as tempdir:
                print(tempdir)
                os.chdir(tempdir)
                result = func(*args, **kwargs)
        finally:
            os.chdir(initial_path)
        return result

    return wrapper
