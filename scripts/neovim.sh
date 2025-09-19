#!/usr/bin/env bash
. "$(dirname "$0")/common.sh"

# Assume repo root is where this script lives, one level up
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NVIM_SOURCE="$REPO_ROOT/nvim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"

install_neovim_pkg() {
  install_pkgs neovim
}

link_nvim_config() {
  if [ -d "$NVIM_SOURCE" ]; then
    if [ -L "$NVIM_CONFIG_DIR" ]; then
      if [ "$(readlink "$NVIM_CONFIG_DIR")" = "$NVIM_SOURCE" ]; then
        info "Neovim config already linked → $NVIM_CONFIG_DIR"
        return
      else
        backup_if_exists "$NVIM_CONFIG_DIR"
      fi
    elif [ -d "$NVIM_CONFIG_DIR" ]; then
      backup_if_exists "$NVIM_CONFIG_DIR"
    fi
    ln -s "$NVIM_SOURCE" "$NVIM_CONFIG_DIR"
    info "Linked Neovim config → $NVIM_CONFIG_DIR"
  else
    warn "No 'nvim' directory found in repo ($NVIM_SOURCE), skipping"
  fi
}

install_lazy() {
  if [ ! -d "$LAZY_DIR" ]; then
    git clone https://github.com/folke/lazy.nvim.git "$LAZY_DIR"
  else
    info "lazy.nvim already installed"
  fi
}

sync_plugins() {
  if has nvim; then
    nvim --headless "+Lazy! sync" +qa || true
  else
    warn "Neovim not installed"
  fi
}

bootstrap_neovim() {
  install_neovim_pkg
  link_nvim_config
  install_lazy
  sync_plugins
  info "Neovim bootstrap complete"
}
