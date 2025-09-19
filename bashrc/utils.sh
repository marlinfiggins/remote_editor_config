workon() {
  if [ -z "$1" ]; then
    echo "Usage: workon <project-dir>"
    return 1
  fi

  local project="$1"
  local projpath="$HOME/projects/$project"

  if [ ! -d "$projpath" ]; then
    echo "⚠️ Project $projpath does not exist."
    return 1
  fi

  # If a tmux session with this name exists, attach; otherwise create
  if tmux has-session -t "$project" 2>/dev/null; then
    tmux attach-session -t "$project"
  else
    tmux new-session -s "$project" -c "$projpath" "nvim"
  fi
}

t() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux not installed"
    return 1
  fi

  local sessions
  IFS=$'\n' read -d '' -r -a sessions < <(tmux list-sessions -F '#S' && printf '\0')

  if [ "${#sessions[@]}" -eq 0 ]; then
    echo "No tmux sessions found."
    return 1
  fi

  local target
  if command -v fzf >/dev/null 2>&1; then
    target=$(printf "%s\n" "${sessions[@]}" | fzf --prompt="Select session> ")
  else
    echo "Available sessions:"
    select s in "${sessions[@]}"; do
      target="$s"
      break
    done
  fi

  [ -z "$target" ] && return 1

  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$target"
  else
    tmux attach-session -t "$target"
  fi
}
