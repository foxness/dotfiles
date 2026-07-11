
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

alias potato-open='cd ~/my/other/minecraftServer'
alias potato-start='~/my/other/minecraftServer/start.sh'
alias potato-backup='~/my/system/scripts/potato-backup/backup.sh'
alias potato-list='~/my/system/scripts/potato-backup/list.sh'
alias potato-prune='~/my/system/scripts/potato-backup/prune.sh'
alias potato-forget-dryrun='~/my/system/scripts/potato-backup/forget-dryrun.sh'
alias potato-forget-for-real='~/my/system/scripts/potato-backup/forget-for-real.sh'

alias rain-backup='~/my/system/scripts/rainworld-backup/backup.sh'
alias rain-list='~/my/system/scripts/rainworld-backup/list.sh'
alias rain-prune='~/my/system/scripts/rainworld-backup/prune.sh'
alias rain-forget-dryrun='~/my/system/scripts/rainworld-backup/forget-dryrun.sh'
alias rain-forget-for-real='~/my/system/scripts/rainworld-backup/forget-for-real.sh'

alias mclient-backup='~/my/system/scripts/mclient-backup/backup.sh'
alias mclient-list='~/my/system/scripts/mclient-backup/list.sh'
alias mclient-prune='~/my/system/scripts/mclient-backup/prune.sh'
alias mclient-forget-dryrun='~/my/system/scripts/mclient-backup/forget-dryrun.sh'
alias mclient-forget-for-real='~/my/system/scripts/mclient-backup/forget-for-real.sh'

alias wallpapers-backup='~/my/system/scripts/wallpapers-backup/backup.sh'
alias wallpapers-list='~/my/system/scripts/wallpapers-backup/list.sh'
alias wallpapers-prune='~/my/system/scripts/wallpapers-backup/prune.sh'
alias wallpapers-forget-dryrun='~/my/system/scripts/wallpapers-backup/forget-dryrun.sh'
alias wallpapers-forget-for-real='~/my/system/scripts/wallpapers-backup/forget-for-real.sh'

# alias python='python3'

# ============ PATH ============

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/opt/homebrew/share"
export PATH="/opt/homebrew/opt/openjdk/bin:/Users/river/.local/bin:/Users/river/.cargo/bin:/opt/homebrew/bin:$PATH"

# ============ INTEGRATION ============

source <(fzf --zsh)
