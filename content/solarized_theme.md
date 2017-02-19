Title: Solarized Theme
Date: 2017-01-10 08:20
Category: Computer
Tags: vim, computer, tmux, terminal
Slug: solarized-theme
Author: John Nduli
status:draft
Summary: Setting up Solarized theme well 

When using a tool or anything for a really long time, one has to
really like how it looks like. I use the terminal, vim and tmux a
lot. So I had to look for a theme that would be easy on my eyes. A
quick internet search revealed solarized, which I then went on to
set up. I have never looked back since then.

## Xfce4 terminal setup ##
Go to Preferences>Colors
Then change the terminal colors to "solarized-dark"

## Vim setup ##
I use vundle as my plugin manager in vim. So setting up solarized
was as easy as adding the following line:
    
    ::vim
    Plugin 'altercation/vim-colors-solarized'

And then running:

    ::vim
    :PluginInstall

After these I added the following lines to my  .vimrc:
    
    ::vim
    syntax enable
    set background=dark
    colorscheme solarized

And vim looked great.
More configuration settings can be found here:
<!-- TODO add link to vim solarized github page -->

## Tmux setup ##
<!-- TODO add link to tmux plugin mangaer -->
I use the tmux plugin manager. SO to setup solarized on tmux, it's
as simple as:
    
    ::bash
    set -g @plugin 'seebi/tmux-colors-solarized'

Then I run prefix + I , whicn in my case it Ctrl+b and then I
press I.

This will download and install the tmux solarized theme.

After this I add the following line to my tmux config:

    ::bash
    set -g @colors-solarized 'dark'

<!-- todo add link to github tmux-colors-solarized -->
