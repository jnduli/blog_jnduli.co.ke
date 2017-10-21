##################################
Disabling Blanking in Raspberry Pi
##################################

:date: 2017-10-17 15:00
:tags: raspberry pi
:category: Engineering
:slug: disabling-blanking-raspberry-pi
:author: John Nduli
:status: published

Blanking is whereby a screen just goes blank (i.e. black screen).
This usually happens after some time of no usage on the raspberry
pi which is about 15 minutes. This can sometimes become
frustrating especially if it is a screen set up for monitoring
something.

So to disable it temporarily: 

.. code-block:: bash

    xset s off # disables screen saver
    xset -dpms #disable power management settings
    xset -s noblank

To disable it permanently, open the file
/etc/lightdm/lightdm.conf:

.. code-block:: bash

    sudo vi /etc/lightdm/lightdm.conf

Then add the following line:

.. code-block:: bash

    xserver-command=X -s 0 -dpms
