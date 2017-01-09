Title: Remapping Keyboard Keys(Esc and Caps)
Date: 2016-12-06 20:20
Category: Computer
Tags: keyboard, computer, vim
Slug: remapping-keyboard-keys-esc-caps
Author: John Nduli
status: published
Summary: Run this in terminal:xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"

I use vim as an editor, and I use it a lot. With that comes some curse. I press
"ESC" a lot. And yet that key is located at a very inconvenient location. Its located at the top row on my keyboard. For a key that I use that much, I would rather it occurs somewhere closer to the home row.

The "CapsLock" key is one that I rarely use. Yet its located at
the home row. Furthermore, its use is redundant because I can
always use the SHIFT key to do the same work.

So I found a nifty trick on how to remap these keys on my keyboard
in linux. 

Open the terminal and type:

    ::bash
    xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"

If this does not work replace: clear Lock with remove Lock = Caps_Lock

    ::bash
    xmodmap -e "remove Lock = Caps_Lock" -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock" -e "keycode 66 = Escape NoSymbol Escape"


However, this change is temporary. On system restart the keyboard
will be the old same.

To make the changes permanent within the system:

    ::bash
    xmodmap -pke >~/.xmodmap
    touch ~/.xinitrc #create file
    xmodmap .xmodmap

This switch is not all hymns and praises.

* My laptop just became more unusable to mugles
* My muscle memory has already got this new configuration. This
 makes it difficult to work with other machines or even in
 windows.

