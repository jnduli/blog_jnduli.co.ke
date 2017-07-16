#######################
Setting Up Raspberry Pi
#######################
:date: 2017-07-16 08:20
:category: Engineering
:tags: raspberry pi
:slug: setting-up-raspberry-pi
:author: John Nduli
:status: draft

The raspberry pi is a mini computer with GPIO pins that can be
used to interface with various sensors and actuators. More
information of the raspberry pi can be found `here
<https://www.raspberrypi.org/>`_

The SD card should be of a size greater than 4GB, especially if
you want to install Raspbian Jesse.

Connect the card to your computer and get its id. To do this:

.. code-block:: bash

    sudo fdisk -l

If you do the above command before inserting the card and after
inserting the card, you'll find a new addition which is the card.

Format the card to fat partition. To do this:

.. code-block:: bash

    sudo umount /dev/sdcardfound
    sudo mkfs.fat /dev/sdcardfound

After this the sd card is ready for use.

Download the OS from 
`here:raspbian <https://www.raspberrypi.org/downloads/raspbian/>`_,
and unzip it. I chose Raspbian Jesse with Desktop for my OS.

.. code-block:: bash

    unzip downloadedraspbian.zip

Then burn the OS into the sd card using dd:

.. code-block:: bash

    sudo dd if=unzippedraspbian.img of=/dev/sdcardfound bs=4M status= progress

Once this step is completed the OS is ready for use.

With Screen, Keyboard and Mouse
===============================

Attach the sd card, screen, keyboard and mouse to the raspberry
pi. For power, a supply rated 5V 2.5A is recommended. In my case,
I used one rate 5V and 1A and it worked well. When powered, there
are two LED lights, a red one and a green one. The red should be
on indicating the pi is receiving power. The green light should be
blinking. If it is not this indicated either a problem with the sd
card or the power supply.

Once the pi is started, wait until the desktop environment is
loaded. Then you can then enable vnc and ssh.

To do this, go to the terminal and type:

.. code-block:: bash

    sudo raspi-config

Go to interface and enable both vnc and ssh.

You can also go to MENU > PREFERENCES > Interfaces. From this you
can also enable ssh and vnc.

To set up a virtual keyboard, first connect to a wifi/LAN network
and do:

.. code-block:: bash

   sudo apt update
   sudo apt install matchbox-keyboard
   sudo reboot


The keyboard should be in accessibility menu.
If it isn't go to MENU > Preferences > Main Menu Editor >
Accesorites. Disable and enable the Keyboard option.

To ssh into the pi, first get the ip address. To do this, hover on
the wifi icon and the ip will be displayed. You can also get the
ip address from the terminal by running:

.. code-block:: bash

    ip address show

From another computer, run:

.. code-block:: bash

    ssh pi@piipaddress


The password is : raspberry

The pi already comes with a vnc server known as realvnc. So just
install the viewer on your laptop and use it. For archlinux:

.. code-block:: bash

    yaourt -S realvnc-vnc-viewer

Then confirm that vnc is enabled on the pi. To use it:

.. code-block:: bash

    vncviewer piipaddress

Realvnc can also be setup to run via the cloud. Just visit their
website `here:realvnc <https://www.realvnc.com/en/>`_ to find out
how.
