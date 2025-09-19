#!/usr/bin/env bash
. "$(dirname "$0")/common.sh"

configure_git_identity() {
  local name="${GIT_NAME:-Marlin Figgins}"
  local email="${GIT_EMAIL:-marlinfiggins@gmail.com}"

  local cur_name
  local cur_email
  cur_name=$(git config --global user.name || echo "")
  cur_email=$(git config --global user.email || echo "")

  if [ "$cur_name" != "$name" ]; then
    git config --global user.name "$name"
    info "Set git user.name → $name"
  fi

  if [ "$cur_email" != "$email" ]; then
    git config --global user.email "$email"
    info "Set git user.email → $email"
  fi

setup_ssh() {
  if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    info "Generating SSH key..."
    mkdir -p ~/.ssh && chmod 700 ~/.ssh
    ssh-keygen -t ed25519 -C "${GIT_EMAIL:-marlinfiggins@gmail.com}" -f "$HOME/.ssh/id_ed25519" -N ""
    cat ~/.ssh/id_ed25519.pub
    info "Add this SSH key to GitHub → Settings → SSH and GPG keys"
    echo "After adding the key, test with: ssh -T git@github.com"
  else
    info "SSH key already exists, skipping"
  fi
}

bootstrap_general() {
  install_pkgs git curl build-essential ripgrep fd-find lazygit
  configure_git_identity
  setup_ssh
  info "General dev tools bootstrap complete"
}
