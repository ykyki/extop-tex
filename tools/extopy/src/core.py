from pathlib import Path

import click

from src import git, lib


@click.group(help='CLI tool of extop', invoke_without_command=True)
@click.pass_context
def cli(context):
    if context.invoked_subcommand is None:
        click.echo('Hello extopy!')
    else:
        pass


@cli.command(help='test current environment')
def test():
    cwd = lib.get_cwd_path()
    click.echo(f'{cwd=}')

    repository_path = git.get_current_repository_path()
    click.echo(f'{repository_path=}')

    click.echo(click.style('Test passed!', fg='green'))


@cli.command(help='Build PDF file')
@click.argument('target')
@click.option('--layout', '-l',
              type=click.Choice(['product', 'develop', 'review']),
              default='product',
              help='Layout setting (default = product)')
def build(target: str, layout: str) -> None:
    import subprocess

    click.echo(f'{target=}, {layout=}')

    repository_path = git.get_current_repository_path()

    target_path = Path(target).resolve()
    target_path_rel = target_path.relative_to(repository_path)

    latexmkrc_path_rel = Path('documents/catalog/.latexmkrc')

    output_dir_rel = Path('temp/')
    output_dir = repository_path / output_dir_rel

    if not (target_path.exists()):
        raise FileNotFoundError(f'{target_path_rel}')
    if not (target_path.suffix == '.tex'):
        raise ValueError(f'Illegal suffix: {target_path_rel.name}')
    if not ((repository_path / latexmkrc_path_rel).exists()):
        raise FileNotFoundError(f'{latexmkrc_path_rel}')
    if not (output_dir.exists()):
        raise FileNotFoundError(f'{output_dir_rel}')

    @lib.run_in_tempdir
    def build_runner():
        tempdir_path = lib.get_cwd_path()

        git.clone(repository_path, tempdir_path)

        with open(tempdir_path / target_path_rel, mode='r', encoding='utf-8') as file:
            file_content = file.read()
        with open(tempdir_path / target_path_rel, mode='w', encoding='utf-8') as file:
            # noinspection SpellCheckingInspection
            replaced = file_content.replace(r'\begin{document}', rf'\setlayout{{{layout}}}\begin{{document}}', 1)
            file.write(replaced)
        del file_content
        del replaced

        # noinspection SpellCheckingInspection
        subprocess.check_output(
            ['latexmk', '-cd', '-norc', '-r', str(latexmkrc_path_rel), str(target_path_rel)],
        )

        import shutil
        shutil.move(
            target_path_rel.with_suffix('.pdf'),
            output_dir / Path(f'{target_path.stem}-{layout}').with_suffix('.pdf')
        )

    build_runner()
