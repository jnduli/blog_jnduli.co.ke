###################
Sway Window Manager
###################
:date: 2019-01-12 08:00
:tags: window-managers
:category: Computer
:slug: sway-window-manager
:author: John Nduli
:status: published

Wayland is a display server that should work as a replacement for X.
I've been thinking of trying it out for some time now. Detailed
information about wayland and its history can be found `in this article
<https://www.linux.com/news/what-why-and-how-wayland-and-weston-linux>`__. The
differences between xorg and wayland can be found `here
<https://www.secjuice.com/wayland-vs-xorg/>`__ or in this `thread
<https://askubuntu.com/questions/11537/why-is-wayland-better>`__. It
seems to me the biggest problem with wayland is that it is not network
aware (although I haven't used this feature yet in xorg preferring using
vnc servers instead) and that some programs will not work with it (for
example, redshift).

However, the biggest block for me was that my i3 workflow had been
ingrained in my muscle memory and I did not want to lose this. Luckily,
I found `sway <https://swaywm.org/>`_. Surprisingly, it worked with most
of my i3 configuration, only having to make changes to custom mapping
applications that were x based e.g. feh.

To set sway up, I decided to avoid the version used in pacman, because
it seemed to be too old. I went with bleeding edge sway and set it up
using:

.. code-block:: bash

   yay -S wlroots-git sway-git

With this I get the latest version plus all its improvements. The
problem though, is that sway sometimes fails to start after a system
update. To fix this, I just start up i3 and run the above command again.

This might be subjective, but I found the colours in swaywm when I first
used it to be better and brighter. This is something I had always wanted
to figure out how to fix in i3, but never got around to doing this.

I also felt that out of the box, it had better support for my touchpad.
It did not have a lot of ghost touches, random scrolling behaviour, etc.
which in i3, I have to spend a lot of time tweaking and configuring the
touchpad settings. In sway, these are the only configurations I had to
enable:

.. code-block:: bash

   input "1267:12328:ELAN1300:00_04F3:3028_Touchpad" {
       dwt enabled
       tap enabled
   }

The problems I have with sway are:

- I haven't found a way to set up a floating terminal window. I have
  defaulted to using a floating window usint this configuration:

   .. code-block:: bash

      bindsym $mod+F12 exec xfce4-terminal --drop-down --title=dropdown
      for_window [title="dropdown"] floating enable

- Switching between keyboard layouts is tricky. The options I've got
  involve restarting sway with the new keyboard layout I intend to use,
  for example:

   .. code-block:: bash

      export XKB_DEFAULT_LAYOUT=us; export XKB_DEFAULT_VARIANT=qwerty; sway

- When connecting an external monitor to my laptop, I expect it to be on
  the right of the laptop screen. However, sway defaults with it on the
  left. To fix this, I set up both screens and their index as shown
  below:

   .. code-block:: bash

      output eDP-1 resolution 1920x1080 position 0,0
      output HDMI-A-1 resolution 1280x1024 position 1920,0
