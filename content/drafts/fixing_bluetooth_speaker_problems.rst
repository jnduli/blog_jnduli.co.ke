###########################
Bluetooth Speakers Problems
###########################
:date: 2018-05-30 08:00
:tags: linux
:category: Computer
:slug: fixing-bluetooth-speaker-problems
:author: John Nduli

Audacity could not link up with my bluetooth speakers during
playback. However, the bluetooth speakesrs were visible from
pavucontrol. To fix this, I had to install alsa-plugins.
.. code-block:: bash

    sudo pacman -S alsa-plugins

Once this was done, the options pulse were available in audio
recording and play back devices.

To connect to the bluetooth speakers, I use the bluetoothctl
commandline options. The following are commands I occassionally
run:

.. code-block:: bash

   sudo systemctl start bluetooth.service
   bluetoothctl
   power on
   agent on
   default-agent
   scan on
   pair A4:A7:B5:22:E6:F5
   connect A4:A7:B5:22:E6:F5
 
If the device had been previously paired, I skip the pair step. 

Sometimes, my bluetooth speakers would connect successfully from
the bluetooth device but no audio would be heard from the
speakers. To fix this, I usually remove the item from the list of
pairted devices and try to pair again before connecting.

.. code-block:: bash

   connect A4:A7:B5:22:E6:F5
