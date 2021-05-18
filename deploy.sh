#!/bin/bash

set -euo pipefail

relpath="$(dirname "$0")"
SRC="$(cd -- "$relpath" && pwd)"
readonly SRC
readonly DST="$HOME"

for f in "$SRC/"* "$SRC/".*; do
    name="$(basename "$f")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    [[ "$name" == ".git" \
        || "$name" == ".gitignore" \
        || "$name" == "bin" \
        || "$name" == "deploy.sh" \
        || "$name" == "deploy-dotfiles.bat" ]] && continue
    ln -s -- "$f" "$DST/$name"
done

mkdir -p -- "$DST/bin"
for f in "$SRC/bin/"* "$SRC/bin/".*; do
    name="$(basename "$f")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    ln -s -- "$f" "$DST/bin/$name"
done
