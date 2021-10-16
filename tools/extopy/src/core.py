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
    click.echo(f'{target=}, {layout=}')
