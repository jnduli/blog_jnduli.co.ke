#################
I3 Window Manager
#################

I've been using xfce4 as my primary window manager for some time
now. Its pretty light weight and works really well on my laptop (
which is really weak btw).

However, I decided I wanted to try out something new. I'd never
actually used another window manager in linux apart from the
defaults provided by various distros and xfce4 ( which I always
install). So I did some digging around and found i3.

i3 is a tiling window manager, and my current default window
manager too. I don't know if its the greatest one or even a good
one. It was just the first other window manager I tried after
xfce4 and I liked it a lot. In fact, I liked it so much that I
haven't tried tinkering with another window manager yet.

To install i3 in archlinux:
    sudo pacman -S i3wm i3lock i3status dmenu

The default i3 config file works but I had to make some of my
changes.

First off, I really like the xfce4-terminal, so I wanted to still
use it as my default terminal. This terminal also has a drop-down
feature which I use a lot, so I also had to figure out a way to do
this. So this was my changes/additions to support this:

.. code-block:: bash

    bindsym $mod+Return exec xfce4-terminal
    #xfce4 dropdown terminal
    bindsym F12 exec xfce4-terminal --drop-down 
    for_window [class="xfce4-terminal"] floating enable


Since I'm a dedicated vim user, I also had to find a way to
customize i3 to work similarly to vim.

.. code-block:: lua

    # change focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # move focused window
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

There are also some custom applications I use, and that I wanted
to start up with i3. An example is redshift. To do that I just
added this to the config file.

.. code-block:: lua

    #redshift
    exec --no-startup-id redshift-gtk

To take a screenshot, I decided to use scrot. Here is my addition
to i3 for that.

.. code-block:: lua

    #scrot screen shot
    bindsym $mod+p exec "scrot ~/Downloads/Screenshot%Y-%m-%d%H:%M:%S.png"

To change the desktop wallpater, I decided to use feh. 
.. code-block:: lua

    #background image
    exec feh --bg-scale ~/Pictures/i3_solarized.png

To use i3lock, add the following to the config:
.. code-block:: lua

    #setting up i3lock
    exec --no-startup-id xautolock -time 1 -locker 'i3lock -n'



