#!/usr/bin/env bash
# Download the large input data of one or more exercises from the GitHub release.
#
# Usage (from the repository root):
#   tools/download_data.sh                         # all exercises
#   tools/download_data.sh exercises/09-lidar-*    # selected exercises
#
# Reads <exercise>/data-manifest.csv (asset,md5,path) and verifies MD5 checksums.
set -euo pipefail

REPO="toihr/Advanced-Remote-Sensing-Exercises"
RELEASE="data-v1.0"
BASE_URL="https://github.com/${REPO}/releases/download/${RELEASE}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

md5_of() {
  if command -v md5sum >/dev/null 2>&1; then md5sum "$1" | cut -d' ' -f1
  else md5 -q "$1"; fi
}

download_exercise() {
  local dir="$1" manifest="$1/data-manifest.csv"
  [[ -f "$manifest" ]] || { echo "No manifest in $dir - skipping"; return; }
  echo "== $(basename "$dir")"

  tail -n +2 "$manifest" | tr -d '\r' | while IFS=, read -r asset md5 path; do
    local target="$dir/$path"
    if [[ "$asset" == *.zip ]]; then
      local marker="$target/.$asset.extracted"
      if [[ -f "$marker" ]]; then echo "[skip] $path/$asset (already extracted)"; continue; fi
      local tmp; tmp="$(mktemp)"
      echo "[get ] $asset -> $path/"
      curl -fL --progress-bar -o "$tmp" "$BASE_URL/$asset"
      [[ "$(md5_of "$tmp")" == "$md5" ]] || { echo "Checksum mismatch: $asset" >&2; exit 1; }
      mkdir -p "$target" && unzip -oq "$tmp" -d "$target" && rm -f "$tmp" && touch "$marker"
    else
      if [[ -f "$target" && "$(md5_of "$target")" == "$md5" ]]; then
        echo "[skip] $path (already present)"; continue
      fi
      mkdir -p "$(dirname "$target")"
      echo "[get ] $asset -> $path"
      curl -fL --progress-bar -o "$target" "$BASE_URL/$asset"
      [[ "$(md5_of "$target")" == "$md5" ]] || { echo "Checksum mismatch: $asset" >&2; exit 1; }
    fi
  done
}

if [[ $# -eq 0 ]]; then set -- "$ROOT"/exercises/*/; fi
for d in "$@"; do download_exercise "${d%/}"; done
