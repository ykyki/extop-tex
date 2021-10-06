import click


@click.command()
@click.argument('target')
@click.option('--layout', '-l', default='develop', help='レイアウト指定')
def main(target, layout):
    print(f'{target=}, {layout=}')
