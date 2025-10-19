# About

This is a collection of my dotfiles and scripts that i've collected over the years.

## How It Works

This is just a snapshot of my home directory (with important files encrypted with git-crypt). This helps me easily set up a new system. The configs are very macos specific, I plan to add Linux support as well soon.

On a new machine I do:

```shell
mkdir /tmp/old

mv .zshrc other_files /tmp/old

git init

git remote add origin https://github.com/thetinygoat/dotfiles.git

git pull origin master --ff-only

chmod 0600 ~/.ssh/config
```

## Things To Look Out For

I may end up re-writing the git histoiy if I end up pushing something sensitive.
