import setuptools


def _requires_from_file(filename):
    return open(filename).read().splitlines()


if __name__ == "__main__":
    setuptools.setup(
        name='extopy',
        version='1.0.0',
        install_requires=_requires_from_file('requirements.txt'),
        extras_requires={
            'development': _requires_from_file('requirements_dev.txt')
        },
        packages={'': 'src'},
        entry_points={
            'console_scripts': [
                'extopy = src.core:cli',
            ],
        },
    )
