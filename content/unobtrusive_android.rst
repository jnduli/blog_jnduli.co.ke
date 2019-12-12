###################
Unobtrusive Android
###################
:date: 2019-10-19
:tags: linux
:category: Computer
:slug: distraction-free-laucher-android
:author: John Nduli
:status: published


Phones are an amazing technology that aid us in our day to day
activities. However, if not careful, the phone can be a dangerous
distraction. This is because applications are readily available to be
tapped whenever I look at my phone and looking at an app icon sometimes
causes me to just want to open it. Another distration is the amount of
notifications you get.

Dummy and feature-less phones have popped up as a solution to this
distraction. Another option I've seen is trying to reduce distractions
on your phone as shown
`here <https://medium.com/make-time/the-distraction-free-android-2fd595c77747>`_.
I found an interesting way of dealing with this though. It involves
installing and using
`TUI <https://github.com/fAndreuzzi/TUI-ConsoleLauncher>`_, a weird
android launcher that is minimalistic and distraction free. 

Out of the box, this provides you a clean non-intrusive UI where you can
access whatever you want (so long as you remember the name). This is a
cool way to prevent you from tapping on some app you did not even think
of using before seeing its icon. Also I've found its faster to use,
especially when I use aliases for common functionalities.


Configuration
-------------

For the default home page, I found that it contained a lot of extra
information that I did not care about. So I changed them using:

.. code-block:: bash

    config -set ram_format RAM: %avgb/%totgb(%av%%)
    config -set storage_format store: %iavgb/%itotgb(%iav%%)
    config -set show_time false
    config -set show_unlock_counter false
    config -set show_battery false
    config -set show_network_info false
    config -set show_device_name false
    config -set system_wallpaper true
    config -set fullscreen true


To set up aliases for common functionality, you just do:

.. code-block:: bash

    alias -add bro call 0712123456

The laucher also has buttons for the most common applications you use at
the bottom of the screen. If you find one that is a distraction, you can
just hide it with:


.. code-block:: bash

    apps -hide Youtube

After applying those configurations, this is what I see when I unlock my
phone every time:


.. image:: {static}/images/cleaned_up_tui_launcher.png
    :alt: cleaned up tui launcher image
