# homebrew setup
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# global setup
export EDITOR=nano
export HISTSIZE=10000
export SAVEHIST=10000

# zsh history quality of life
setopt append_history inc_append_history share_history hist_ignore_dups hist_ignore_space

# case insensitive completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# path mutations (always prepend)
export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$HOME/.cargo/bin:$HOME/scripts:/usr/local/go/bin:$PATH"

# aliases
if command -v bat > /dev/null 2>&1; then
    alias cat=bat
fi

if command -v batcat > /dev/null 2>&1; then
    alias cat=batcat
fi

if command -v rg > /dev/null 2>&1; then
    alias grep=rg
fi

if command -v fd > /dev/null 2>&1; then
    alias find=fd
fi

if ls --color=auto >/dev/null 2>&1; then
    alias ls='ls --color=auto'   # GNU/coreutils
else
    alias ls='ls -G'             # macOS/BSD
fi
alias l='ls -l'
alias la='ls -la'
alias ll='ls -lh'

alias ..='cd ..'
alias ...='cd ../..'

alias gst="git status"
alias gr="git remote -v"
alias gra="git remote add"
alias grrm="git remote remove"
alias gpl="git pull"
alias gp="git push"
alias glg="git log --oneline"
alias gf="git fetch"
alias gco="git checkout"
alias gcl="git clone"
alias gcb="git checkout -b"
alias gc="git commit -v"
alias gaa="git add ."
alias ga="git add"
alias gca="git commit --amend"
alias gcane="git commit --amend --no-edit"
alias gsh="git stash"
alias gshp="git stash pop"
alias gb="git branch"

# fzf setup
if command -v fzf > /dev/null 2>&1; then
    source <(fzf --zsh)
fi

# fnm setup
if command -v fnm > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit snippet OMZ::/plugins/git/git.plugin.zsh
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
