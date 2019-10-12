#!/usr/bin/env bash
set -eu

artifacts="${GITHUB_WORKSPACE:-/build}/packages/${INPUT_NAME:-default}"

mkdir -p /packages/

mkdir -p "$artifacts"

compile "${GITHUB_WORKSPACE:-src}/${INPUT_SOURCE:-}" /packages/ > /dev/null

for f in "/packages/"*"_zip.txt"; do
  if [ -f "$f" ]; then
    mv "$f" "$artifacts/compressed"
    echo ::set-output name=compressed::"$artifacts/compressed"
  fi

  break
done

for f in "/packages/"*".txt"; do
  if [ -f "$f" ]; then
    mv "$f" "$artifacts/uncompressed"
    echo ::set-output name=uncompressed::"$artifacts/uncompressed"
  fi

  break
done
