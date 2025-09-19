#!/usr/bin/env bash
set -euo pipefail

# Utilities
has() { command -v "$1" >/dev/null 2>&1; }

info()  { echo -e "\033[1;34m[INFO]\033[0m $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error() { echo -e "\033[1;31m[ERR ]\033[0m $*"; }

backup_if_exists() {
  local p="$1"
  if [ -e "$p" ] || [ -L "$p" ]; then
    mv -v "$p" "${p}.bak.$(date +%Y%m%d-%H%M%S)"
  fi
}

# Package Manager Abstraction
install_pkgs() {
  local pkgs=()
  # only add packages that are not already installed
  for pkg in "$@"; do
    if ! has "$pkg"; then
      pkgs+=("$pkg")
    fi
  done

  if [ "${#pkgs[@]}" -eq 0 ]; then
    info "All requested packages already installed"
    return 0
  fi

  info "Installing packages: ${pkgs[*]}"

  if has apt; then
    sudo apt update -y
    sudo apt install -y "${pkgs[@]}"
    if has fdfind && ! has fd; then
      sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    fi
  elif has pacman; then
    sudo pacman -Syu --noconfirm "${pkgs[@]}"
  elif has dnf; then
    sudo dnf install -y "${pkgs[@]}" || true
  elif has yum; then
    sudo yum install -y "${pkgs[@]}" || true
  elif has zypper; then
    sudo zypper install -y "${pkgs[@]}"
  elif has brew; then
    brew install "${pkgs[@]}"
  else
    warn "No supported package manager found. Please install manually: ${pkgs[*]}"
  fi
}
