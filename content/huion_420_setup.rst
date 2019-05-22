######################
Huion 420 driver setup
######################

:date: 2019-04-27 19:00
:tags: linux, product, review
:category: Computer
:slug: huion-420-driver-setup
:author: John Nduli
:status: published

I bought the Huion 420 because I wanted to experiment with graphics
tablet and drawing on linux. I chose this primarily because of its cost.
Out of the box, the device worked on my archlinux setup, however it
behaved more like a mouse, with pressure sensitivity not detected. I did
some research and this is how I fixed this.

I first had to install the digimend drivers. To do that:

.. code-block:: bash

    sudo pacman -S linux-headers
    yay -S digimend-kernel-drivers-dkms-git

I had to unload previous versions of the drivers using modprobe.

.. code-block:: bash

    sudo modprobe -r hid-kye hid-uclogic hid-polostar hid-viewsonic


The default settings were not to my liking and I found out there exists
a tool that configures wacom tablets that can work with other models. It
is a hit or miss whether this tool will work with your tablet, but in my
case, it worked perfectly. To install the tool:

.. code-block:: bash

    sudo pacman -S xf86-input-wacom


And then set up this file in xorg i.e. in my case, I created the file
`/etc/X11/xorg.conf.d/52-tablet.conf`.

.. code-block:: bash

    Section "InputClass"
        Identifier "Huion on wacom"
        MatchProduct "HUION"
        MatchDevicePath "/dev/input/event*"
        Driver "wacom"
    EndSection


To check if this worked, I restarted the laptop and ran:

.. code-block:: bash

    xsetwacom --list

Seeing the contents below confirmed that the configuration had worked:

.. code-block:: bash

    HUION 420 Pad pad                       id: 21  type: PAD
    HUION 420 Pen stylus                    id: 22  type: STYLUS

To edit the pressure of the tool, I used gimp. For this go to
`Edit>Input Devices`, select the `HUION 420 Pen stylus` and set `mode`
to `Screen`. The pressure was then be detected in gimp.

References:

- https://github.com/DIGImend/digimend-kernel-drivers
- https://wiki.archlinux.org/index.php/Wacom_tablet

