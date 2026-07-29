
# river .zshrc config
# created on 2025/02/08

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# ============ PATH ============

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/opt/homebrew/share"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ============ INTEGRATION ============

source <(fzf --zsh)

# ============ ALIASES ============

# alias keyboardmaestro='/Applications/Keyboard\ Maestro.app/Contents/MacOS/keyboardmaestro'

alias ls='eza --long --color=always --icons=always --no-user --time-style long-iso --sort type'
alias lsa='ls --all'
alias ca='bat'

# sa means source aliasse :)
alias sa='source ~/.zshrc;echo "ZSH config loaded."'
alias oc='open .'
alias gos='cd ~/my/system/scripts'
alias myip='curl https://icanhazip.com/'

alias vim='nvim'
alias vi='nvim'

alias dotfiles='git --git-dir=$HOME/my/system/git/dotfiles.git/ --work-tree=$HOME'
alias dfs='dotfiles'
alias dfss='dfs status -s'
alias dfsd='dfs diff'
alias dfsa='dfs add -u'
alias dfsc='dfs commit -m'
alias dfsp='dfs push'

alias gs='git status -s'
alias gdi='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

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

alias confvi='vi ~/.config/nvim/init.lua'
alias confkarabiner='vi ~/.config/karabiner.edn'
alias confzsh='vi ~/.zshrc'


















