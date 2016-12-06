Title: Remapping Keyboard Keys
Date: 2016-12-06 20:20
Category: Computer
Tags: keyboard, computer, vim
Slug: remapping-keyboard-keys
Author: John Nduli
Summary: Run this in terminal:xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"

# Remapping my CapsLock key to Escape #
I uses vim as an editor, and with that comes a curse. I press
"ESC" a lot. However, I wanted to turn lemons into lemonades. So
what would I do? 

I found a nifty trick on how to remap key on my keyboard in linux.
So I remapped the one key I rarely used to escape. This was the
Capslock key. Now that is a useless key. Anyway, how did I
accomlish that?
    
Open the terminal and type:

    ::bash
    xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"

If this does not work replace: clear Lock with remove Lock = Caps_Lock

    ::bash
    xmodmap -e "remove Lock = Caps_Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"


However, this change is temporary. On system restart the keyboard
will be the old same.

To make the change permanent within the system:

    ::bash
    xmodmap -pke >~/.xmodmap
    touch ~/.xinitrc #create file
    xmodmap .xmodmap

This switch is not all hymns and praises. It has its downs. First
is that my laptop just became one step closer to being used by
another human being on the planet. Next is that I dual boot on
windows, and haven't yet done the mapping on that platform. This
makes it frustating sometimes since my muscle memory is already
used to the new configuration. Anyway, I use windows leses and
lless so this is a non issue so far.
