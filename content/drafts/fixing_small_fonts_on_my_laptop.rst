###############################
Fixing Small Fonts on My Laptop
###############################

:date: 2918-09-17 16:20
:tags: computer, linux
:category: Computer
:slug: fixing-small-fonts-on-my-laptop
:author: John Nduli
:status: drafts

I have been having this bugging problem with my laptop where the
fonts seem too small. To fix this, I first had to check out my
laptop's screen configurations:

.. code-block:: bash

   xrandr

Part of the output of this command is shown below. As can be seen it shows that my laptop screen is 'eDP1' and has dimensions of 290mm by 170mm.

.. code-block:: bash

   Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 32767 x 32767
   eDP1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 290mm x 170mm
      1920x1080     60.05*+  59.93  
      1680x1050     59.88  


Another command that can find screen information is:

.. code-block:: bash

   xdpyinfo| grep -B2 resolution

This command shows different screen dimensions. Its output is
shown below:

.. code-block:: bash

   screen #0:
     dimensions:    1920x1080 pixels (508x285 millimeters)
     resolution:    96x96 dots per inch


There is some discrepancy somewhere. To fix this, I had to create
a monitor configuration file in
`/etc/X11/xorg.conf.d/90.monitor.conf` that contained the correct
screen dimensions. I got the screen dimensions by measuring them
with a tape measure. The contents of the file are:

.. code-block:: bash

   Section "Monitor"
       Identifier             "eDP1"
       DisplaySize            290 170   
   EndSection

I then restarted i3 and my screen read comfortably. The
output from the xdpyinfo command shows:

.. code-block:: bash

   screen #0:
     dimensions:    1920x1080 pixels (290x170 millimeters)
     resolution:    168x161 dots per inch


