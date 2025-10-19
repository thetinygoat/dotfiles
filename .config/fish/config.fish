# homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# global setup
set -gx EDITOR nano
set -gx HISTSIZE 10000
set -gx SAVEHIST 10000
set -g fish_greeting

# QOL abbreviations
abbr --add cat bat
abbr --add codex codex --search
abbr --add grep rg
abbr --add find fd

# git abbreviations
abbr --add gst git status
abbr --add gr git remote -v
abbr --add gra git remote add
abbr --add grrm git remote remove
abbr --add gpl git pull --ff-only
abbr --add gp git push
abbr --add glg git log --oneline
abbr --add gf git fetch
abbr --add gco git checkout
abbr --add gcl git clone
abbr --add gcb git checkout -b
abbr --add gc git commit -v
abbr --add gaa git add .
abbr --add ga git add
abbr --add gca git commit --amend
abbr --add gcane git commit --amend --no-edit
abbr --add gsh git stash
abbr --add gshp git stash pop
abbr --add gb git branch

# fish abbreviations
abbr --add reload source ~/.config/fish/config.fish

# bun setup
set -gx BUN_INSTALL ~/.bun
fish_add_path $BUN_INSTALL/bin

# fzf setup
fzf --fish | source

# rust and cargo setup
fish_add_path $HOME/.cargo/bin

# custom scripts
fish_add_path $HOME/scripts

# fnm setup
fnm env --use-on-cd --shell fish | source
