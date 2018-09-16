###########################
Bluetooth Speakers Problems
###########################
:date: 2018-09-14 08:00
:tags: linux
:category: Computer
:slug: fixing-bluetooth-speaker-problems
:author: John Nduli
:status: published


Connecting to Device
--------------------
To connect to the bluetooth speakers, I use the bluetoothctl
commandline options. The following are commands I run for this to
work:

.. code-block:: bash

   sudo systemctl start bluetooth.service
   bluetoothctl
   # Within the bluetoothctl environment
   power on
   agent on
   default-agent
   scan on
   pair A4:A7:B5:22:E6:F5
   connect A4:A7:B5:22:E6:F5
 
If the device had been previously paired, I skip the pair step. 

Sometimes, my bluetooth speakers would fail to connect. To fix
this, I usually remove the item from the list of paired devices
and try to pair again before connecting.

.. code-block:: bash

   remove A4:A7:B5:22:E6:F5

Another problem I've experience is whereby the device connects but
I can't hear sound from the speakers. To fix this, I first confirm
that the device is set up as an a2dp device in pavucontrol. If
this change has been made and there is still no sound, kill
pulseaudio.

.. code-block:: bash

   pulseaudio --kill


Audacity
--------
         
Audacity could not link up with my bluetooth speakers during
playback. However, the bluetooth speakers were visible from
pavucontrol and I could hear audio from them when using other
applications. To fix this, I had to install alsa-plugins.

.. code-block:: bash

    sudo pacman -S alsa-plugins

Once this was done, the options pulse were available in audio
recording and play back devices.

