import setuptools


def _requires_from_file(filename):
    return open(filename).read().splitlines()


if __name__ == "__main__":
    setuptools.setup(
        name='build=py',
        version='0.0.1',
        install_requires=_requires_from_file('requirements.txt'),
        packages={'': 'mylib'},
        entry_points={
            'console_scripts': [
                'build_by_path = mylib.build_by_path:main',
            ],
        },
    )
