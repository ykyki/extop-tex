import os

from src.lib import *


def test_get_cwd_path():
    print(get_cwd_path())
    assert get_cwd_path().exists()


def test_run_in_tempdir():
    @run_in_tempdir
    def test_func():
        print(os.getcwd())
        assert True
        return get_cwd_path()

    assert get_cwd_path() != test_func()
    print(os.getcwd())
