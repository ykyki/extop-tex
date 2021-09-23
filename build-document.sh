#!/bin/sh
# set -x

OUTPUT_DIR=$(pwd)/products
REPO_DIR=$(cd "$(dirname "$0")" && pwd -P)

if   [ $# = 0 ]; then
    REPO_VER=catalog
    OUTPUT_SUFFIX=$(date '+%y%m%d-%H%M%S')
elif [ $# = 1 ]; then
    REPO_VER=$1
    OUTPUT_SUFFIX=$1
else
    echo 'usage: build-and-export.sh [version]'
    exit
fi

if git rev-parse --verify "$REPO_VER" >/dev/null 2>&1; then
    echo "Version: $REPO_VER"
else
    echo "Invalid version: $REPO_VER"
    echo "Example: HEAD, {hash}, {tag}"
    echo "To see tags: git tag -l"
    exit 1
fi

printf 'Select Project:'
printf '
    1  ) catalog/root
    11 ) catalog/chapter-basics
'
printf 'Select: '
read -r OPTION

case $OPTION in
    '1' )
        PROJECT='catalog'
        ROOT_FILE='documents/catalog/main-root' # without filename extension
        LATEXMKRC_FILE='documents/catalog/.latexmkrc'
        ;;
    '11' )
        PROJECT='catalog-basics'
        ROOT_FILE='documents/catalog/chapter-basics'
        LATEXMKRC_FILE='documents/catalog/.latexmkrc'
        ;;
    * )
        echo 'Wrong Input.'
        exit 1
        ;;
esac

echo

TMP_DIR=/tmp/$(mktemp -u extop-XXX)
git clone "$REPO_DIR" "$TMP_DIR"
cd "$TMP_DIR" || exit
git checkout "$REPO_VER"
latexmk -cd -r $LATEXMKRC_FILE $ROOT_FILE.tex > /dev/null
mv $ROOT_FILE.pdf "$OUTPUT_DIR"/$PROJECT-"$OUTPUT_SUFFIX".pdf

echo
echo "Build: $OUTPUT_DIR/$PROJECT-$OUTPUT_SUFFIX.pdf"

rm -rf "$TMP_DIR"
cd - || exit

exit 0
