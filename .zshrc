
# river .zshrc config
# created on 2025/02/08

# ============ COLORS ============

autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
# PS1="%B%F{034}%n@%m%f%b:%B%F{019}%~ %#%f%b "
# PS1="%F{214}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{015}%K{000}\$ "
# PROMPT='%F{240}%n%F{red}@%F{green}%m:%F{141}%d$ %F{reset}'
# PS1='%(?.%F{green}.%F{red})%n@%m:%~%# %f'

# ============ TIME PROMPT ============

# autoload -Uz vcs_info
# precmd() { vcs_info }

# zstyle ':vcs_info:git:*' formats '%b '

# setopt PROMPT_SUBST
# PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# ============ ALIASES ============

# alias keyboardmaestro='/Applications/Keyboard\ Maestro.app/Contents/MacOS/keyboardmaestro'

alias ls='ls --color=auto'
alias lsa='ls --color=auto -la'
alias sa='source ~/.zshrc;echo "ZSH aliases sourced."'
alias oc='open .'
alias dotfiles='git --git-dir=$HOME/my/system/git/dotfiles.git/ --work-tree=$HOME'
alias gs='cd ~/my/system/scripts'

alias fs-start='~/my/system/scripts/fileserver/start.sh'
alias fs-stop='~/my/system/scripts/fileserver/stop.sh'

# alias python='python3'

# ============ PATH ============

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/opt/homebrew/share"
export PATH="/opt/homebrew/opt/openjdk/bin:/Users/river/.local/bin:/Users/river/.cargo/bin:/opt/homebrew/bin:$PATH"

# ============ INTEGRATION ============

source <(fzf --zsh)
