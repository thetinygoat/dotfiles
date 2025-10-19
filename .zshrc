export PATH="/opt/homebrew/bin:/opt/homebrew/opt/openjdk/bin:/Users/sachin/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

. "$HOME/.local/bin/env"
