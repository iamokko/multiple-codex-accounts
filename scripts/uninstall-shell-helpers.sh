#!/usr/bin/env bash
set -euo pipefail

BEGIN_MARKER="# >>> multiple-codex-accounts >>>"
END_MARKER="# <<< multiple-codex-accounts <<<"

RC_FILE="${1:-}"

detect_rc_file() {
  if [[ -n "$RC_FILE" ]]; then
    return
  fi

  case "${SHELL:-}" in
    */zsh) RC_FILE="${ZDOTDIR:-$HOME}/.zshrc" ;;
    */bash)
      if [[ "$(uname -s)" == "Darwin" ]]; then
        RC_FILE="$HOME/.bash_profile"
      else
        RC_FILE="$HOME/.bashrc"
      fi
      ;;
    *) RC_FILE="$HOME/.profile" ;;
  esac
}

detect_rc_file

if [[ ! -f "$RC_FILE" ]]; then
  echo "[OK] Nothing to remove; $RC_FILE does not exist."
  exit 0
fi

tmp="$(mktemp)"
awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" '
  $0 == begin { skip = 1; next }
  $0 == end { skip = 0; next }
  skip != 1 { print }
' "$RC_FILE" > "$tmp"
mv "$tmp" "$RC_FILE"

echo "[OK] Removed shell helpers from $RC_FILE"
echo "Account directories were left untouched."
