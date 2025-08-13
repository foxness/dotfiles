#!/bin/zsh
# updates the configs in this directory

# source:destination pairs
typeset -a files=(
    ~/Library/Application\ Support/com.mitchellh.ghostty/config:ghostty-config
    ~/Library/Application\ Support/Code/User/settings.json:vscode-settings.json
    ~/.config/zed/settings.json:zed/settings.json
    ~/.config/zed/keymap.json:zed/keymap.json
    ~/.config/karabiner.edn:karabiner.edn
    ~/.zprofile:zprofile
    ~/.zshrc:zshrc
)

for pair in "${files[@]}"; do
    src="${pair%%:*}"   # part before :
    dst="${pair##*:}"   # part after :

    if [[ ! -f "$src" ]]; then
        echo "WARNING: source file missing: $src"
        continue
    fi

    # make sure destination folder exists
    mkdir -p -- "${dst:h}"

    echo "Copying: $src → $dst"
    cp -- "$src" "$dst"
done
