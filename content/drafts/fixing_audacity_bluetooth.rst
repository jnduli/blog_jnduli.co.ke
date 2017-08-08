Audacity could not link up with my blue tooth speakers during
playback. However, this were shown in pavucontrol.

After a lot of googling, I found out I had to install
alsa-plugins.

.. code-block:: bash

    sudo pacman -S alsa-plugins

Once this was done, the options pulse were available in audio
recording and play back devices.

