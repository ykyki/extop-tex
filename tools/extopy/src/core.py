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

    repository_path = git.get_current_repository_root_path()
    click.echo(f'{repository_path=}')

    click.echo(click.style('Test passed!', fg='green'))


@cli.command(help='Build PDF file')
@click.argument('target')
@click.option('--layout', '-l', default='develop', help='レイアウト指定')
def build(target: str, layout: str) -> None:
    import subprocess

    click.echo(f'{target=}, {layout=}')

    repository_path = git.get_current_repository_root_path()

    target_path = Path(target).resolve()
    target_path_rel = target_path.relative_to(repository_path)
    target_stem = target_path.stem

    latexmkrc_path_rel = Path('documents/catalog/.latexmkrc')

    output_dir_rel = Path('temp/')
    output_dir = repository_path / output_dir_rel

    if not (target_path.exists()):
        _echo_error(f'File not found: {target_path_rel}')
        return
    if not ((repository_path / latexmkrc_path_rel).exists()):
        _echo_error(f'File not found: {latexmkrc_path_rel}')
        return
    if not (output_dir.exists()):
        _echo_error(f'File not found: {output_dir}')
        return

    @lib.run_in_tempdir
    def build_runner():
        tempdir_path = lib.get_cwd_path()

        git.clone(repository_path, tempdir_path)
        subprocess.check_output(
            ['latexmk', '-cd', '-norc', '-r', str(latexmkrc_path_rel), str(target_path_rel)]
        )

        import shutil
        shutil.move(
            target_path_rel.with_suffix('.pdf'),
            output_dir / Path(f'{target_stem}-from-temp').with_suffix('.pdf')
        )

    build_runner()


def _echo_error(message: str) -> None:
    click.echo(click.style(message, fg='red'))
