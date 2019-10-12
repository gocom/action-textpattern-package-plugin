#!/usr/bin/env sh
set -eu

mkdir -p /packages/

mkdir -p "$HOME/packages/$INPUT_NAME"

compile "$GITHUB_WORKSPACE/$INPUT_SOURCE" /packages/ > /dev/null

compressed="$HOME/packages/$INPUT_NAME/compressed"

uncomressed="$HOME/packages/$INPUT_NAME/uncompressed"

for f in "/packages/"*"_zip.txt"; do
  mv "$f" "$compressed"
  echo ::set-output name=compressed::"$compressed"
  break
done

for f in "/packages/"*".txt"; do
  mv "$f" "$uncomressed"
  echo ::set-output name=uncompressed::"$uncomressed"
  break
done

echo ::set-output name=tag::"${TAG}"
