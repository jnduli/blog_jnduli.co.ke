#################
Adb Usage at Work
#################
:date: 2017-04-09 08:20
:category: Computer
:tags: adb, computer
:slug: adb-usage-at-work
:author: John Nduli
:status: published

To use adb in archlinux, first install android-tools.

.. code-block:: bash

    sudo pacman -S android-tools


I then add the adb resources to the android rules files. To do
this, first do lsusb, you'll get something like this:

.. code-block:: bash

    lsusb
    Bus 001 Device 004: ID 12d1:256b Huawei Technologies Co., Ltd.

To add this to the rules, open up
/etc/udev/rules.d/51-android.rules
And add this:

.. code-block:: bash

    SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0660", GROUP="plugdev"


To list all the packages installed:

.. code-block:: bash

    adb shell pm list packages -f

To get the main activity of a package

.. code-block:: bash

    adb shell pm dump com.randompackage.android.application | grep -A 1 MAIN

To launch activities

.. code-block:: bash

    #launches the launcher activity
    adb shell monkey -p app.package.name -c android.intent.category.LAUNCHER 1


or:

.. code-block:: bash

    adb shell am start -n com.package.name/com.package.name.ActivityName

To start a specific action

.. code-block:: bash

    am start -a com.example.ACTION_NAME -n com.package.name/com.package.name.ActivityName

To install apk

.. code-block:: bash

    #if not previously installed
    adb install filename.apk
    #if it had been installed eg. when upgrading
    adb install -r filename.apk
