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

# load compinit function definition
autoload -Uz compinit

# completion init
if [[ -f $HOME/.zcompdump ]]; then
  compinit -u -C
else
  compinit -u
fi

# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select=2

# path mutations (always prepend)
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$HOME/.cargo/bin:$HOME/scripts:/usr/local/go/bin:$PATH"


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
alias lh='ls -lh'

alias ..='cd ..'
alias ...='cd ../..'

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
zinit ice lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit snippet OMZ::/plugins/git/git.plugin.zsh

PURE_GIT_PULL=0
PURE_GIT_DELAY_DIRTY_CHECK=999999
PURE_GIT_OPTION_FETCH=0
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure


zinit ice wait'1' lucid
zinit light zsh-users/zsh-syntax-highlighting
