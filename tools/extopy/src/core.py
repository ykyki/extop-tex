from pathlib import Path

import click

from src import git, lib


@click.group(help='CLI tool for extop-tex', invoke_without_command=True)
@click.pass_context
def cli(context):
    if context.invoked_subcommand is None:
        click.echo('Hello extopy!')
    else:
        pass


# @cli.command(help='Test current environment')
# def test():
#     cwd = lib.get_cwd_path()
#     click.echo(f'{cwd=}')
#
#     repository_path = git.toplevel()
#     click.echo(f'{repository_path=}')
#
#     click.echo(click.style('Test passed!', fg='green'))


@cli.command(help='Build PDF file')
@click.argument('target')
@click.option('--layout', '-l',
              type=click.Choice(['product', 'develop', 'review']),
              default='product',
              help='Layout setting (default = product)')
@click.option('--revision', '-r',
              default='HEAD',
              help='Revision setting (default = HEAD)')
def build(target: str, layout: str, revision: str) -> None:
    click.echo(f'{target=}, {layout=}, {revision=}')

    repository_path = git.toplevel()

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

    # noinspection SpellCheckingInspection
    @lib.run_in_tempdir
    def build_runner():
        tempdir_path = lib.get_cwd_path()

        git.clone(repository_path, tempdir_path)
        git.checkout(git.revision(revision))

        with open(tempdir_path / target_path_rel, mode='r', encoding='utf-8') as file:
            file_content = file.read()
        with open(tempdir_path / target_path_rel, mode='w', encoding='utf-8') as file:
            replaced = file_content.replace(r'\begin{document}', rf'\setlayout{{{layout}}}\begin{{document}}', 1)
            file.write(replaced)
        del file_content
        del replaced

        import subprocess
        subprocess.check_output(
            ['latexmk', '-cd', '-norc', '-r', str(latexmkrc_path_rel), str(target_path_rel)],
        )

        destination_path = output_dir / Path(
            f'{target_path.stem}_{layout}_{git.revision(revision, is_short=True)}'
        ).with_suffix('.pdf')

        import shutil
        shutil.move(
            target_path_rel.with_suffix('.pdf'),
            destination_path
        )

        click.echo(click.style(f'Done! :{destination_path}', fg='green'))

    build_runner()


@cli.command(help='Build PDF file with diff')
@click.argument('target')
@click.option('--old', '-o',
              default='develop',
              help='Older revision (default = develop)')
@click.option('--new', '-n',
              default='HEAD',
              help='Newer revision (default = HEAD)')
def diff(target: str, old: str, new: str) -> None:
    click.echo(f'{target=}, {old=}, {new=}')

    repository_path = git.toplevel()

    target_path = Path(target).resolve()
    target_path_rel = target_path.relative_to(repository_path)

    old_revision = git.revision(old)
    new_revision = git.revision(new)

    latexmkrc_path_rel = Path('documents/catalog/.latexmkrc')

    output_dir_rel = Path('temp/')
    output_dir = repository_path / output_dir_rel

    # noinspection SpellCheckingInspection
    @lib.run_in_tempdir
    def build_runner():
        tempdir_path = lib.get_cwd_path()

        git.clone(repository_path, tempdir_path)
        git.checkout(new_revision)

        old_target_path_rel = target_path_rel.with_stem(target_path.stem + '-old')
        diff_target_path_rel = target_path_rel.with_stem(target_path.stem + '-diff')

        git.show_and_save(target_path_rel, old_revision, old_target_path_rel)

        import subprocess
        output = subprocess.check_output(
            ['latexdiff', '-e', 'utf8', '-t', 'CFONT', '--flatten', str(old_target_path_rel), str(target_path_rel)],
            encoding='utf-8'
        )
        with open(diff_target_path_rel, mode='w', encoding='utf-8') as file:
            file.write(output)
        del output

        subprocess.check_output(
            ['latexmk', '-cd', '-norc', '-r', str(latexmkrc_path_rel), str(diff_target_path_rel)],
        )

        destination_path = output_dir / Path(
            f'{target_path.stem}_{git.revision(old, is_short=True)}_{git.revision(new, is_short=True)}'
        ).with_suffix('.pdf')

        import shutil
        shutil.move(
            diff_target_path_rel.with_suffix('.pdf'),
            destination_path
        )

        click.echo(click.style(f'Done! :{destination_path}', fg='green'))

    build_runner()

    pass
