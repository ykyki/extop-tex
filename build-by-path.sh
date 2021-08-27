#!/bin/sh
# set -x

REPO_DIR=$(cd "$(git rev-parse --show-toplevel)" && pwd -P)
OUTPUT_DIR=$REPO_DIR/products

LATEXMKRC_FILE='documents/main/.latexmkrc'

DOC_LAYOUT='product'
REPO_VER='HEAD'

if [ $# = 1 ]; then
  TARGET_PATH=$1
elif [ $# = 2 ]; then
  TARGET_PATH=$1
  DOC_LAYOUT=$2
elif [ $# = 3 ]; then
  TARGET_PATH=$1
  DOC_LAYOUT=$2
  REPO_VER=$3
else
  echo 'usage: build-by-path.sh [path] [layout (default = product)] [version (default = HEAD)]'
  exit 1
fi

OUTPUT_SUFFIX=$DOC_LAYOUT-$REPO_VER
# OUTPUT_SUFFIX=$(date '+%y%m%d-%H%M%S')

TARGET_DIR=$(dirname "$TARGET_PATH")
TARGET_NAME=$(basename "$TARGET_PATH" ".tex")

if test -f "$REPO_DIR/$TARGET_DIR/$TARGET_NAME.tex"; then
  echo "Target path: [repository root]/$TARGET_PATH"
else
  echo "Invalid path: [repository root]/$TARGET_PATH"
  exit 1
fi

case $DOC_LAYOUT in
'product' | 'develop' | 'review')
  echo "Layout: $DOC_LAYOUT"
  ;;
*)
  echo "Invalid layout: $DOC_LAYOUT"
  exit 1
  ;;
esac

if git rev-parse --verify "$REPO_VER" >/dev/null 2>&1; then
  echo "Version: $REPO_VER"
  GIT_HASH=$(git rev-parse --verify "$REPO_VER")
else
  echo "Invalid version: $REPO_VER"
  echo
  echo "Example: HEAD, {hash}, {tag}"
  echo "To see tags: git tag -l"
  exit 1
fi

TMP_DIR=/tmp/$(mktemp -u extop-XXX)
git clone "$REPO_DIR" "$TMP_DIR"
cd "$TMP_DIR" || exit
git checkout "$GIT_HASH"

sed -i '' -e "s/\\begin{document}/\\setlayout{$DOC_LAYOUT} \\\begin{document}/" "$TARGET_PATH"

latexmk -cd -r "$LATEXMKRC_FILE" "$TARGET_PATH" >/dev/null &&
  mv -i "$TARGET_DIR/$TARGET_NAME.pdf" "$OUTPUT_DIR"/"$TARGET_NAME"-"$OUTPUT_SUFFIX".pdf &&
  echo &&
  echo "Build: $OUTPUT_DIR/$TARGET_NAME-$OUTPUT_SUFFIX.pdf"

rm -rf "$TMP_DIR"
cd - || exit

exit 0
