#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(dirname "$0")/scripts"

. "$SCRIPTS_DIR/common.sh"
. "$SCRIPTS_DIR/dotfiles.sh"

WITH_DOTFILES=1

for arg in "$@"; do
  case "$arg" in
    --no-dotfiles) WITH_DOTFILES=0 ;;
    --help)
      echo "Usage: $0 [options]"
      echo ""
      echo "Options:"
      echo "  --no-dotfiles  Skip tmux + bash aliases setup"
      echo "  --help         Show this help message"
      exit 0
      ;;
  esac
done

[ "$WITH_GENERAL"  -eq 1 ] && bootstrap_general
[ "$WITH_DOTFILES" -eq 1 ] && bootstrap_dotfiles

info "All requested bootstrap steps complete."
