#!/usr/bin/env bash
. "$(dirname "$0")/common.sh"

install_uv() {
  if ! has uv; then
    info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
  else
    info "uv already installed"
  fi
}

install_python_tools() {
  install_pkgs python3 python3-pip # fallback for distros without uv’s bundled python
  info "Installing Python dev tools via uv..."
  uv tool install black ruff ipython jupyterlab poetry --force
}

bootstrap_python() {
  install_uv
  install_python_tools
  info "Python bootstrap complete"
}
