import src.lib
from src.git import *


def test_get_current_repository_path():
    assert get_current_repository_path().exists()


def test_get_current_repository_path_in_tempdir():
    @src.lib.run_in_tempdir
    def test_func():
        return get_current_repository_path()

    try:
        test_func()
        assert False
    except subprocess.CalledProcessError:
        assert True


# noinspection PyPep8Naming
def test_revision():
    SHA1_LENGTH = 40
    SHA1_SHORT_LENGTH = 7

    rev = revision('HEAD')
    assert len(rev) == SHA1_LENGTH
    rev = revision('HEAD', is_short=True)
    assert len(rev) == SHA1_SHORT_LENGTH
