#!/usr/bin/env bash
set -eu

main () {
  local directory file workspace

  workspace="${GITHUB_WORKSPACE:-$PWD}"

  directory="$workspace/${INPUT_OUTPUT:-build/packages}/"

  mkdir -p "$directory"

  compile "$workspace/${INPUT_SOURCE:-}" "$directory" > /dev/null

  for file in "$directory"*_zip.txt; do
    if [ -f "$file" ]; then
      echo ::set-output name=compressed::"${file#$workspace/}"
    fi

    break
  done

  for file in "$directory"*.txt; do
    if [ -f "$file" ] && ! [[ $file == *_zip.txt ]]; then
      echo ::set-output name=uncompressed::"${file#$workspace/}"
      meta "$file"
      break
    fi
  done
}

meta () {
  local name

  name="$(basename "${1:-abc_unknown_v0.0.0}")"
  name="${name%.*}"

  echo ::set-output name=name::"${name%_*}"
  echo ::set-output name=version::"${name#*_v}"
}

main
