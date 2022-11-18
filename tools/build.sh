#!/bin/sh
# set -x
set -eu

REPO_DIR=$(cd "$(git rev-parse --show-toplevel)" && pwd -P)
OUTPUT_DIR=$REPO_DIR/temp

LINE_SEPARATOR='----- ----- ----- ----- ----- ----- ----- ----- '

DOC_LAYOUT='product'
REPO_VER='HEAD'

if [ $# -eq 1 ]; then
    TARGET_PATH=$1
elif [ $# -eq 2 ]; then
    TARGET_PATH=$1
    DOC_LAYOUT=$2
elif [ $# -eq 3 ]; then
    TARGET_PATH=$1
    DOC_LAYOUT=$2
    REPO_VER=$3
else
    echo 'usage: build-by-path.sh [path] [layout (default = product)] [version (default = HEAD)]' >&2
    exit 1
fi

TARGET_DIR=$(dirname "$TARGET_PATH")
TARGET_NAME=$(basename "$TARGET_PATH" ".tex")

if [ -f "$REPO_DIR/$TARGET_DIR/$TARGET_NAME.tex" ]; then
    echo "Target path: [repository root]/$TARGET_PATH"
else
    echo "Invalid path: [repository root]/$TARGET_PATH" >&2
    exit 1
fi

LATEXMKRC_FILE='documents/catalog/.latexmkrc'
if [ -f "$LATEXMKRC_FILE" ]; then
    echo "Config file: [repository root]/$LATEXMKRC_FILE"
else
    echo "Config file not found: [repository root]/$LATEXMKRC_FILE" >&2
    exit 1
fi

case "$DOC_LAYOUT" in
    'product' | 'develop' | 'review')
        echo "Layout: $DOC_LAYOUT"
        ;;
    *)
        echo "Invalid layout: $DOC_LAYOUT" >&2
        exit 1
        ;;
esac

if git rev-parse --verify "$REPO_VER" >/dev/null 2>&1; then
    GIT_HASH=$(git rev-parse --verify "$REPO_VER")
    GIT_HASH_SHORT=$(git rev-parse --short "$REPO_VER")
    echo "Version: $REPO_VER ($GIT_HASH_SHORT)"
else
    echo "Invalid version: $REPO_VER" >&2
    exit 1
fi

echo "$LINE_SEPARATOR"

TMP_DIR=/tmp/$(mktemp -u extop-XXX)
git clone "$REPO_DIR" "$TMP_DIR"
cd "$TMP_DIR" || exit
git -c advice.detachedHead=false checkout "$GIT_HASH"

sed -i -e "s/\\\\begin{document}/\\\\setlayout{$DOC_LAYOUT} \\\\begin{document}/" "$TARGET_PATH"

# OUTPUT_SUFFIX=$DOC_LAYOUT-$REPO_VER
OUTPUT_SUFFIX=$DOC_LAYOUT-$GIT_HASH_SHORT
# OUTPUT_SUFFIX=$(date '+%y%m%d-%H%M%S')

latexmk -cd -norc -r "$LATEXMKRC_FILE" "$TARGET_PATH" &&
    mv "$TARGET_DIR/$TARGET_NAME.pdf" "$OUTPUT_DIR"/"$TARGET_NAME"-"$OUTPUT_SUFFIX".pdf &&
    echo "$LINE_SEPARATOR" &&
    echo "Build: $OUTPUT_DIR/$TARGET_NAME-$OUTPUT_SUFFIX.pdf"

if [ $? -ne 0 ]; then exit 1; fi

rm -rf "$TMP_DIR"
cd - || exit 1

exit 0

