#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(dirname "$0")/scripts"

. "$SCRIPTS_DIR/common.sh"
. "$SCRIPTS_DIR/general.sh"
. "$SCRIPTS_DIR/neovim.sh"
. "$SCRIPTS_DIR/python.sh"
. "$SCRIPTS_DIR/dotfiles.sh"

WITH_GENERAL=1
WITH_NEOVIM=1
WITH_PYTHON=1
WITH_DOTFILES=1

for arg in "$@"; do
  case "$arg" in
    --no-general)  WITH_GENERAL=0 ;;
    --no-neovim)   WITH_NEOVIM=0 ;;
    --no-python)   WITH_PYTHON=0 ;;
    --no-dotfiles) WITH_DOTFILES=0 ;;
    --help)
      echo "Usage: $0 [options]"
      echo ""
      echo "Options:"
      echo "  --no-general   Skip installing general dev tools (git, ssh, etc.)"
      echo "  --no-neovim    Skip Neovim config + plugins"
      echo "  --no-python    Skip Python/uv setup"
      echo "  --no-dotfiles  Skip tmux + bash aliases setup"
      echo "  --help         Show this help message"
      exit 0
      ;;
  esac
done

[ "$WITH_GENERAL"  -eq 1 ] && bootstrap_general
[ "$WITH_NEOVIM"   -eq 1 ] && bootstrap_neovim
[ "$WITH_PYTHON"   -eq 1 ] && bootstrap_python
[ "$WITH_DOTFILES" -eq 1 ] && bootstrap_dotfiles

info "All requested bootstrap steps complete."
