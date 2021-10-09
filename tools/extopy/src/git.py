import subprocess


def is_in_git_repository() -> bool:
    try:
        subprocess.check_call(['git', 'rev-parse', '--show-toplevel'])
        return True
    except subprocess.CalledProcessError as ex:
        print(ex.stderr)
        return False
