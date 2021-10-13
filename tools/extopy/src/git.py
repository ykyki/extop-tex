import subprocess
import typing


def is_in_git_repository() -> typing.Tuple[bool, str]:
    # try:
    #     # noinspection SpellCheckingInspection
    #     output = subprocess.run(
    #         ['git', 'rev-parse', '--show-toplevel'],
    #         encoding='utf-8',
    #         capture_output=True,
    #         check=True
    #     )
    #     return True, output.stdout.strip()
    # except subprocess.CalledProcessError as ex:
    #     return False, ex.stderr.strip()
    exitcode, output = subprocess.getstatusoutput('git rev-parse --show-toplevel')
    return exitcode == 0, output
