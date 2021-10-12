import click

from src import git


@click.group(help='CLI tool of extop', invoke_without_command=True)
@click.pass_context
def cli(context):
    if context.invoked_subcommand is None:
        click.echo('Hello extopy!')
    else:
        pass


@cli.command(help='Build PDF file')
@click.argument('target')
@click.option('--layout', '-l', default='develop', help='レイアウト指定')
def build(target: str, layout: str) -> None:
    click.echo(f'{target=}, {layout=}')
    succeeded, output = git.is_in_git_repository()
    if succeeded:
        click.echo(output)
    else:
        click.echo(click.style('Error:', fg='red'))
        click.echo(output)
