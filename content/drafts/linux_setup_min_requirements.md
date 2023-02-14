Title: My Minimum Viable Linux Setup
Date: 2023-04-01
Category: Random
Slug: my_minimum_viable_linux_setup
Author: John Nduli
%% Summary: TODO


I have the following challenges with how I set up my linux boxes:

- My [install script](https://github.com/jnduli/dotfiles/blob/3c850b2f6daec024ad3c57b4ea60dc884614f74f/install.sh#L34>)
  doesn't support other OSes apart from archlinux.
- I don't have a comprehensive list of what I need. I'll install packages on the
  and take time debugging why some feature I expected doesn't work. 
- I don't have documentation / links to how I set something up last time e.g.
  setting up stack-static on Ubuntu wasn't obvious to me.

To counter this, I'm researching `guix` as a package manager and its ecosystem.
I'll maintain a rough list of what I use in the meantime and update it:

## Core Must Haves

- i3-gaps dmenu feh maim scrot dunst dmenu xautolock :The window manager I use
  and utilities I use with it.
- neovim (at least 0.7)
- iosevka font
- zsh ohmyzsh
- alacritty terminal (doesn't matter too much, but I've got a decent config set
  up and my i3 configs assume this)
- tmux
- curl
- tasklite https://github.com/jnduli/TaskLite
- ledger https://www.ledger-cli.org/3.0/doc/ledger3.html
- fzf

## Development Tools

- golang gore
- python ipython
- rust
- stack-static (for haskell development): Add installation in arch and ubuntu
%% - TODO: clean up
- LSP servers:
    - pyright (set up pyright.json at home directory)
    - bash-language-server
- linters (used with ALE):
    - shellcheck
    - proselint
    - writegood
- git
- docker, docker-compose
- entr
- sqlite3

## Others

- cal (terminal calendar) sudo apt install ncal in ubuntu
- vd (visidata)
- anki
