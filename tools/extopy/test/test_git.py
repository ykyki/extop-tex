import src.lib
from src.git import *


def test_get_current_repository_root_path():
    assert get_current_repository_root_path().exists()


def test_get_current_repository_root_path_in_tempdir():
    @src.lib.run_in_tempdir
    def test_func():
        return get_current_repository_root_path()

    try:
        test_func()
        assert False
    except subprocess.CalledProcessError:
        assert True
