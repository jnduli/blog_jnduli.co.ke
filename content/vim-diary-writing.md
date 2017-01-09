Title: Remapping Keyboard Keys(Esc and Caps)
Date: 2016-12-06 20:20
Category: Computer
Tags: keyboard, computer, vim
Slug: remapping-keyboard-keys-esc-caps
Author: John Nduli
status:draft
Summary: Run this in terminal:xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"

A diary is a good way to write down one's thoughts and memories of
the day. 

Being a vim fan, I had to find a waya to easily help me write donw
my diary. This is where vim wiki comes in. It is basically a means
of writing down wikis in vim, and has an awesome diary mode.

FIrst of all install it. I use vundle as my plugin manager. So I
put this in my .vimrc:

<!--TODO include how to install-->

To use the diary mode, type \wi to enter the diary mode.

To input a new diary entry, type \w\w. It opens up a file with its
name the current dat:e
