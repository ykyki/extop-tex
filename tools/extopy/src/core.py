import click


@click.command()
@click.argument('target')
@click.option('--layout', '-l', default='develop', help='レイアウト指定')
def build_by_path(target: str, layout: str) -> None:
    print(f'{target=}, {layout=}')
