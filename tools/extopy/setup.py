import setuptools


def _requires_from_file(filename):
    return open(filename).read().splitlines()


command_prefix = 'extop'

if __name__ == "__main__":
    setuptools.setup(
        name='extopy',
        version='0.0.1',
        install_requires=_requires_from_file('requirements.txt'),
        packages={'': 'src'},
        entry_points={
            'console_scripts': [
                f'{command_prefix}_build_by_path = src.core:build_by_path',
            ],
        },
    )
