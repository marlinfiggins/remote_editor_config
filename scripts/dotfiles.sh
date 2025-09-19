#!/usr/bin/env bash
. "$(dirname "$0")/common.sh"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

install_tmux() {
  install_pkgs tmux
}

link_tmux_conf() {
  local source="$REPO_ROOT/tmux.conf"
  local target="$HOME/.tmux.conf"

  if [ -f "$source" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
      info "tmux.conf already linked → $target"
    else
      backup_if_exists "$target"
      ln -s "$source" "$target"
      info "Linked tmux.conf → $target"
    fi
  else
    warn "No tmux.conf found in repo, skipping"
  fi
}

link_bash_aliases() {
  local source="$REPO_ROOT/bashrc/aliases.sh"
  local target="$HOME/.bash_aliases"   # common convention

  if [ -f "$source" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
      info "Aliases already linked → $target"
    else
      backup_if_exists "$target"
      ln -s "$source" "$target"
      info "Linked aliases.sh → $target"
    fi
  else
    warn "No aliases.sh found in repo, skipping"
  fi

  # Ensure ~/.bashrc sources ~/.bash_aliases
  local bashrc="$HOME/.bashrc"
  if ! grep -q "if \[ -f ~/.bash_aliases \]" "$bashrc"; then
    {
      echo ""
      echo "# Source user aliases"
      echo "if [ -f ~/.bash_aliases ]; then"
      echo "  . ~/.bash_aliases"
      echo "fi"
    } >> "$bashrc"
    info "Updated $bashrc to source ~/.bash_aliases"
  fi
}

bootstrap_dotfiles() {
  install_tmux
  link_tmux_conf
  link_bash_aliases
  info "Dotfiles bootstrap complete"
}
