#!/usr/bin/env bash
set -euo pipefail

COUNT="${1:-5}"
PREFIX="${MCA_PREFIX:-acc}"
BASE_DIR="${CODEX_ACCOUNTS_DIR:-$HOME/.codex-accounts}"

if ! [[ "$COUNT" =~ ^[1-9][0-9]*$ ]]; then
  echo "Usage: $0 [count]" >&2
  exit 2
fi

for ((i = 1; i <= COUNT; i++)); do
  printf "%s%s: " "$PREFIX" "$i"
  CODEX_HOME="$BASE_DIR/${PREFIX}${i}" codex login status 2>&1 | sed -n "1p" || true
done
