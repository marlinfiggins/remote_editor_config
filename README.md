# Remote Editing Config

I want to code and only focus on that.  
This repo gets rid of the BS for me.

## Quick Start

Clone this repo and run the bootstrap script. It will set up:

- General dev tools (git, curl, build tools, ripgrep, fd, lazygit, ssh key)
- Neovim (with my config + plugins via lazy.nvim)
- Python (via [uv](https://github.com/astral-sh/uv), with black/ruff/ipython/jupyterlab/poetry)
- Dotfiles (tmux config + bash aliases for `nvim` and `lazygit`)

### Install

```bash
git clone https://github.com/marlinfiggins/remote_editor_config.git
cd ~/remote_editing

# Optional: set your Git identity for commits and SSH
export GIT_NAME="Your Name"
export GIT_EMAIL="you@example.com"

bash bootstrap-dev.sh
```

### Options
```bash
./bootstrap-dev.sh --no-general   # Skip general dev tools
./bootstrap-dev.sh --no-neovim    # Skip Neovim setup
./bootstrap-dev.sh --no-python    # Skip Python setup
./bootstrap-dev.sh --no-dotfiles  # Skip tmux + aliases
./bootstrap-dev.sh --ssh-only     # Only generate an SSH key
```


## Repo Layout

````
remote_editing/
  bootstrap-dev.sh        # Orchestrator
  scripts/                # Modular components
    common.sh
    general.sh
    neovim.sh
    python.sh
    dotfiles.sh
  nvim/                   # Neovim config
  tmux.conf               # Tmux config
  bashrc/
    aliases.sh            # Aliases + EDITOR settings
    utils.sh
````

## What you get?

- Neovim → my config, lazy.nvim, plugins auto-synced
- Python → uv + dev tools ready to go
- Git → name/email set, ssh key generated if missing
- tmux → sane defaults from my repo
- Bash → aliases (v → nvim, lg → lazygit), EDITOR set to Neovim

Here’s a workflow section you can drop straight into your README:

## Example Workflow on a fresh machine

1. Update system packages

```bash
sudo apt update && sudo apt upgrade -y    # (Debian/Ubuntu example)
```

2. Clone this repo and (optionally) set info

```bash
git clone https://github.com/marlinfiggins/remote_editing.git ~/remote_editing
cd ~/remote_editing
```

```bash
export GIT_NAME="Your Name"
export GIT_EMAIL="you@example.com"
```

3. Run the bootstrap

```bash
chmod +x bootstrap-dev.sh
bash bootstrap-dev.sh
```

4. Start coding
```bash
tmux        # load tmux with your config
v .         # open Neovim in the current project
lg          # manage git repos with lazygit
```
