#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VIMRC_SOURCE="$ROOT_DIR/vim/.vimrc"
VIMRC_TARGET="$HOME/.vimrc"

install_vim() {
  if command -v vim >/dev/null 2>&1; then
    echo "[INFO] vim already installed → $(command -v vim)"
    return
  fi

  echo "[INFO] Installing vim..."
  if command -v apt >/dev/null 2>&1; then
    sudo apt update -y
    sudo apt install -y vim
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y vim
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y vim
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm vim
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y vim
  else
    echo "[WARN] Could not detect package manager, please install vim manually." >&2
  fi
}

link_vimrc() {
  if [ -f "$VIMRC_SOURCE" ]; then
    ln -sf "$VIMRC_SOURCE" "$VIMRC_TARGET"
    echo "[INFO] Linked $VIMRC_SOURCE → $VIMRC_TARGET"
  else
    echo "[WARN] No vim/.vimrc found in repo, skipping symlink."
  fi
}

install_vim
link_vimrc
echo "[INFO] Vim-only setup complete. Run with: vim"
