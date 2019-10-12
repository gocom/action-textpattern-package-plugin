#!/usr/bin/env bash
set -eu

if ! [ "${INPUT_NAME:-}" ]; then
  INPUT_NAME="default"
fi

mkdir -p /packages/

mkdir -p "$HOME/packages/$INPUT_NAME"

compile "${GITHUB_WORKSPACE:-src}/${INPUT_SOURCE:-}" /packages/ > /dev/null

compressed="$HOME/packages/$INPUT_NAME/compressed"

for f in "/packages/"*"_zip.txt"; do
  if [ -f "$f" ]; then
    mv "$f" "$compressed"
    echo ::set-output name=compressed::"$compressed"
  fi

  break
done

uncomressed="$HOME/packages/$INPUT_NAME/uncompressed"

for f in "/packages/"*".txt"; do
  if [ -f "$f" ]; then
    mv "$f" "$uncomressed"
    echo ::set-output name=uncompressed::"$uncomressed"
  fi

  break
done
