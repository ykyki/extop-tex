#!/bin/sh
set -x

REPO_DIR=$(git rev-parse --show-toplevel)
WORKDIR=$(dirname $1)
DIFFNAME=$(basename $1 .tex)-diff-$2-$3
OLD=$(mktemp -u $WORKDIR/latex-diff.XXXXXX).tex
NEW=$(mktemp -u $WORKDIR/latex-diff.XXXXXX).tex

git show "$2:$1" > $OLD
git show "$3:$1" > $NEW

latexdiff -e utf8 -t CFONT --flatten "$OLD" "$NEW" > $WORKDIR/$DIFFNAME.tex
# latexdiff -e utf8 -t CTRADITIONAL --flatten "$OLD" "$NEW" > $WORKDIR/$DIFFNAME.tex
latexmk -cd -norc -r $REPO_DIR/catalog/.latexmkrc -gg $WORKDIR/$DIFFNAME.tex > /dev/null

rm -f $NEW
rm -f $OLD
latexmk -cd -norc -c $WORKDIR/$DIFFNAME.tex

open $WORKDIR/$DIFFNAME.pdf &
xdg-open $WORKDIR/$DIFFNAME.pdf &

