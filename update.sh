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

mode="$1"

if [[ $mode == "pull" ]]; then
    echo "Pulling..."
elif [[ $mode == "push" ]]; then
    echo "Pushing..."
else
    echo "Incorrect command argument. Valid commands: pull, push"
    exit 1
fi

for pair in "${files[@]}"; do
    src="${pair%%:*}"   # part before :
    dst="${pair##*:}"   # part after :

    if [[ $mode == "push" ]]; then
        tmp=$src
        src=$dst
        dst=$tmp
    fi

    if [[ ! -f "$src" ]]; then
        echo "WARNING: source file missing: $src"
        exit 1
    fi

    if [[ $mode == "pull" ]]; then
        # make sure destination folder exists
        mkdir -p -- "${dst:h}"
    fi

    echo "Copying: $src → $dst"
    cp -- "$src" "$dst"
done
