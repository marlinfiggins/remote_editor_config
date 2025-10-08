#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VIMRC_SOURCE="$ROOT_DIR/vim/.vimrc"
COLORS_SOURCE_DIR="$ROOT_DIR/vim/colors"

VIMRC_TARGET="$HOME/.vimrc"
VIM_DIR="$HOME/.vim"
COLORS_TARGET_DIR="$VIM_DIR/colors"

backup_if_exists() {
  local p="$1"
  if [ -e "$p" ] || [ -L "$p" ]; then
    mv -v "$p" "${p}.bak.$(date +%Y%m%d-%H%M%S)"
  fi
}

install_vim() {
  if command -v vim >/dev/null 2>&1; then
    echo "[INFO] vim already installed → $(command -v vim)"
    return
  fi
  echo "[INFO] Installing vim..."
  if command -v apt >/dev/null 2>&1; then
    sudo apt update -y && sudo apt install -y vim
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y vim
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y vim
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm vim
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y vim
  else
    echo "[WARN] Could not detect package manager; please install vim manually." >&2
  fi
}

link_vimrc() {
  if [ -f "$VIMRC_SOURCE" ]; then
    mkdir -p "$VIM_DIR"
    if [ ! -L "$VIMRC_TARGET" ] || [ "$(readlink "$VIMRC_TARGET" || true)" != "$VIMRC_SOURCE" ]; then
      [ -e "$VIMRC_TARGET" ] && backup_if_exists "$VIMRC_TARGET"
      ln -s "$VIMRC_SOURCE" "$VIMRC_TARGET"
      echo "[INFO] Linked $VIMRC_SOURCE → $VIMRC_TARGET"
    else
      echo "[INFO] Vim config already linked → $VIMRC_TARGET"
    fi
  else
    echo "[WARN] No vim/.vimrc found in repo, skipping symlink."
  fi
}

link_colors() {
  if [ -d "$COLORS_SOURCE_DIR" ]; then
    mkdir -p "$COLORS_TARGET_DIR"
    # Symlink each colorscheme file so we don't clobber other user files
    shopt -s nullglob
    for f in "$COLORS_SOURCE_DIR"/*.vim; do
      local base="$(basename "$f")"
      local target="$COLORS_TARGET_DIR/$base"
      if [ ! -L "$target" ] || [ "$(readlink "$target" || true)" != "$f" ]; then
        [ -e "$target" ] && backup_if_exists "$target"
        ln -s "$f" "$target"
        echo "[INFO] Linked colorscheme $base"
      else
        echo "[INFO] Colorscheme already linked → $base"
      fi
    done
    shopt -u nullglob
  else
    echo "[WARN] No vim/colors/ directory in repo, skipping colors."
  fi
}

install_vim
link_vimrc
link_colors
echo "[INFO] Vim-only setup complete. Try: vim"
