
# river .zshrc config
# created on 2025/02/08

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ============ ALIASES ============

# alias keyboardmaestro='/Applications/Keyboard\ Maestro.app/Contents/MacOS/keyboardmaestro'

# sa means source aliases :)
# alias sa='source ~/.zshrc;echo "ZSH config loaded."'
alias sa='ZSH_RELOADED=1 exec zsh'

alias ls='eza --long --color=always --icons=always --no-user --time-style long-iso --sort type'
alias lsa='ls --all'
alias ca='bat'

alias oc='open .'
alias gos='cd ~/my/system/scripts'
alias myip='curl https://icanhazip.com/'

alias vim='nvim'
alias vi='nvim'

alias dotfiles='git --git-dir=$HOME/my/system/git/dotfiles.git/ --work-tree=$HOME'
alias dot='dotfiles'
alias dotstat='dot status -s'

alias gitstat='git status -s'

alias fileserver-start='~/my/system/scripts/fileserver/start.sh'
alias fileserver-stop='~/my/system/scripts/fileserver/stop.sh'

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

alias confvi='vi ~/.config/nvim/init.lua'
alias confkarabiner='vi ~/.config/karabiner.edn'
alias confzsh='vi ~/.zshrc'
alias confghostty='vi ~/.config/ghostty/config'

# ============ ZSH ENHANCEMENTS ============

source <(fzf --zsh)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ============ RELOAD PRINT ============

if [[ -n "$ZSH_RELOADED" ]]; then
    echo "ZSH reloaded."
fi












