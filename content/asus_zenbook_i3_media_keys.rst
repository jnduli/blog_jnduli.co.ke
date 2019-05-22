###################################################
Asus Zenbook Keyboard & Screen Brightness Fix On i3
###################################################
:date: 2017-09-01 14:00
:tags: linux
:category: Computer
:slug: asus-zenbook-keyboard-screen-issues-fix
:author: John Nduli
:status: published

Keyboard backlight fix
=======================

Source for this information can be found `here <https://wiki.archlinux.org/index.php/Keyboard_backlight>`_

The link has a file called kb-light.py. I set up this file in
/usr/local/bin.

I then opened my i3config file and added the following:

.. code-block:: vim

    bindsym XF86KbdBrightnessUp exec python /usr/local/bin/kb-light.py +
    bindsym XF86KbdBrightnessDown exec python /usr/local/bin/kb-light.py -

And now when I press the keyboard brightness up and down key, the
keyboard lights change as expected.

Screen brightness fix
=====================

For this I wanted to use xbacklight. The problem I got was that
when I tried

.. code-block:: vim

    xbacklight -inc 10


I got the error "No outputs have backlight propery".

To fix this, I installed the intel driver

 .. code-block:: vim

    sudo pacman -S xf86-video-intel

And after rebooting it worked well.
So to set up the keyboard keys for screen brightness, I added this to my i3 config file:

.. code-block:: vim

    bindsym XF86MonBrightnessUp exec xbacklight -inc 10 # increase screen brightness
    bindsym XF86MonBrightnessDown exec xbacklight -dec 10 # decrease screen brightness

Media Keys Usage Fix
====================

For this, I first had to install pulseaudio.

.. code-block:: vim

    sudo pacman -S pulseaudio

Then I added this to my i3 config files:

 .. code-block:: vim

    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

Now audio can be increased / decreased using my media keys.

My i3 config file can be found `here:i3_config_file <https://github.com/jnduli/dotfiles>`_
