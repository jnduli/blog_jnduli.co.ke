Title: My Minimum Viable Linux Setup
Date: 2023-04-01
Category: Random
Slug: my_minimum_viable_linux_setup
Author: John Nduli
%% Summary: TODO


I have the following challenges with how I set up my linux boxes:
- The `install script
  <https://github.com/jnduli/dotfiles/blob/3c850b2f6daec024ad3c57b4ea60dc884614f74f/install.sh#L34>`_
  doesn't support other OSes apart from archlinux
- I don't have a comprehensive list of what I need. This means I don't get the
  functionality I expect and I spend time figuring our what is missing.
- I don't have documentation / links to how I set something up last time e.g.
  setting up stack-static on Ubuntu wasn't obvious to me.

To counter this, I'm looking into using `guix` as a package manager, and getting
familiar with this ecosystem although it isn't a magic gun that solves
everything.

In the short term I'll maintain a rough list of what I use and regularly update
this doc:

## Window Manager and Related Tools

- i3-gaps (or the latest version of i3 that merged gaps changes)
- dmenu
- i3-gaps feh maim scrot dunst dmenu xautolock 


## Terminal Tools

- alacritty terminal (doesn't matter too much though, but I've got a decent config set up here)
- iosevka font
- zsh
- ohmyzsh
- cal (terminal calendar) sudo apt install ncal in ubuntu
- vd (visidata)
- curl
- tmux


## Development Tools

- golang
    - gore
- python
    - ipython
- rust
- stack-static for hkell development
- neovim (at least 0.7)
- fzf
- linters (used with ALE):
    - shellcheck
    - proselint
    - writegood
    - TODO: list all linters I need to have here
- git
- docker, docker-compose
- stack-static
- LSP:
    - pyright (set up pyright.json at home directory)
    - bash-language-server
- entr
- docker
- zsh
- sqlite3

## Others

- tasklite
- anki
- grep
- paplay
- ledger


## Fonts

- iosevka
- noto-fonts-emoji


