#!/bin/sh
# set -x

REPO_DIR=$(cd "$(git rev-parse --show-toplevel)" && pwd -P)
OUTPUT_DIR=$REPO_DIR/products

if [ $# = 1 ]; then
  TARGET_PATH=$1
  REPO_VER="HEAD"
  # OUTPUT_SUFFIX=$(date '+%y%m%d-%H%M%S')
  OUTPUT_SUFFIX="HEAD"
elif [ $# = 2 ]; then
  TARGET_PATH=$1
  REPO_VER=$2
  OUTPUT_SUFFIX=$2
else
  echo 'usage: build-by-path.sh [path] [version (default = HEAD)]'
  exit
fi

TARGET_DIR=$(dirname "$TARGET_PATH")
TARGET_NAME=$(basename "$TARGET_PATH" ".tex")

if test -f "$REPO_DIR/$TARGET_DIR/$TARGET_NAME.tex"; then
  echo "Target path: [repository root]/$TARGET_PATH"
else
  echo "Invalid path: [repository root]/$TARGET_PATH"
  exit 1
fi

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

LATEXMKRC_FILE='documents/main/.latexmkrc'

TMP_DIR=/tmp/$(mktemp -u extop-XXX)
git clone "$REPO_DIR" "$TMP_DIR"
cd "$TMP_DIR" || exit
git checkout "$GIT_HASH"

latexmk -cd -r "$LATEXMKRC_FILE" "$TARGET_PATH" >/dev/null &&
  mv -i "$TARGET_DIR/$TARGET_NAME.pdf" "$OUTPUT_DIR"/"$TARGET_NAME"-"$OUTPUT_SUFFIX".pdf &&
  echo &&
  echo "Build: $OUTPUT_DIR/$TARGET_NAME-$OUTPUT_SUFFIX.pdf"

rm -rf "$TMP_DIR"
cd - || exit

exit 0
