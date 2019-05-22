Title: Tmux Usage
Date: 2017-02-05 08:20
Category: Computer
Tags: linux 
Slug: tmux-usage
Author: John Nduli
status: published
Summary: How I use tmux to help me out with xfce4-terminal

I use xfce4-terminal which is really awesome. It light on my
computer and yet heavy on features. It has tabs, a drop down
terminal option, and many more.

However, I soon came to realize I needed something more. Something
that I could use with together with the features of
xfce4-terminal. That's when I got to find tmux.

Tmux put simple is a terminal multiplexer, meaning it gives you
multiple terminals within the same window i.e kinda like tabs but
more powerful. You can have multiple windows on the same screen(it
works like vsplit and hsplit of vim) and multiple windows in the
same session.

To make you understand, I just have to show you how to use it:

    ::bash
    sudo pacman -S tmux

To start a tmux session:

    ::bash
    tmux

After than you can create mutliple windows on screen or in buffers

    ::bash
    C-b c " creates a new buffer
    C-b , ' renames a new buffer
    C-b number "moves to the numbered buffer
    C-b " 'Creates a vsplit
    C-b % "creates a hsplit

To move through sections I wanted to use vim directional buttons
h,j,k,l so I had to configure this in tmux config file. So I
created a .tmux.conf in my home folder and added the following:

    ::bash
    bind -r k select-pane -U 
    bind -r j select-pane -D 
    bind -r h select-pane -L 
    bind -r l select-pane -R 

So if I have multiplw window splits on screen, I just do:

    ::bash
    C-b h/j/k/l " move to window

I also set the resizing of split to use 

    ::bash
    bind -r C-k resize-pane -U
    bind -r C-j resize-pane -D
    bind -r C-h resize-pane -L
    bind -r C-l resize-pane -R

So to resize a window split I just do:

    ::bash
    C-b C-h/j/k/l

If you have multiple windows and have exited from one, the
numbering is usually flawed ie. it can be 1,2,4,5. To renumber the
windows, I do

    ::bash
    C-n : "command mode
    movew -r "renumber the windows

