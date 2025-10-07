#!/usr/bin/env bash
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

install_uv() {
  if ! has uv; then
    info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
    export PATH="$HOME/.local/bin:$PATH"
  else
    info "uv already installed"
  fi
}

install_python_tools() {
  install_pkgs python3 python3-pip # fallback for distros without uv’s bundled python
  info "Installing Python dev tools via uv..."
  for tool in black ruff ipython jupyterlab; do
    uv tool install "$tool" --force || true
  done
}

bootstrap_python() {
  install_uv
  install_python_tools
  info "Python bootstrap complete"
}
