
# river .zprofile config
# created on 2025/02/08

# ============ VARIABLES ============

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/opt/homebrew/share"

typeset -U path PATH  # (optional zsh trick: enforces unique entries in PATH)
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/openjdk/bin"
  $path
)
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by swiftly
. "$HOME/.swiftly/env.sh"
