# global variables
set -gx EDITOR nano
set -gx BUN_INSTALL ~/.bun
set -gx HISTSIZE 10000
set -gx SAVEHIST 10000
set -g fish_greeting

# path mutations
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path ~/.local/bin
fish_add_path ~/tools/kafka/bin
fish_add_path $BUN_INSTALL/bin

# abbrs
# git
abbr --add cat bat
abbr --add codex codex --search
abbr --add grep rg
abbr --add gst git status
abbr --add gr git remote -v
abbr --add gra git remote add
abbr --add grrm git remote remove
abbr --add gpl git pull
abbr --add gp git push
abbr --add glg git log --oneline
abbr --add gf git fetch
abbr --add gco git checkout
abbr --add gcl git clone
abbr --add gcb git checkout -b
abbr --add gc git commit -v
abbr --add gaa git add .
abbr --add gca git commit --amend
abbr --add gcane git commit --amend --no-edit
abbr --add gsh git stash
abbr --add gshp git stash pop
abbr --add gb git branch

# fish
abbr --add reload source ~/.config/fish/config.fish




