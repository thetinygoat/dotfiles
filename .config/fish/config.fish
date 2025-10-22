# homebrew setup
if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
end

# global setup
set -gx EDITOR nano
set -gx HISTSIZE 10000
set -gx SAVEHIST 10000
set -g fish_greeting
fish_add_path $HOME/.local/bin

# QOL abbreviations
if type -q bat
    abbr --add cat bat
end

if type -q batcat
    abbr --add cat batcat
end

if type -q codex
    abbr --add codex codex --search
end

if type -q rg
    abbr --add grep rg
end

if type -q fd
    abbr --add find fd
end

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
if type -q fzf
    fzf --fish | source
end

# rust and cargo setup
fish_add_path $HOME/.cargo/bin

# custom scripts
fish_add_path $HOME/scripts

# fnm setup
if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

# load secrets
if test -f $HOME/.config/fish/secrets.fish
    source $HOME/.config/fish/secrets.fish
end
