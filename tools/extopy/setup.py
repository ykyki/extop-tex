import setuptools

import src.core


def _requires_from_file(filename):
    return open(filename).read().splitlines()


if __name__ == "__main__":
    setuptools.setup(
        name='extopy',
        version='0.0.1',
        install_requires=_requires_from_file('requirements.txt'),
        packages={'': 'src'},
        entry_points={
            'console_scripts': [
                'extopy = src.core:cli',
            ],
        },
    )
