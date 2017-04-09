Title: Adb Usage at Work
Date: 2017-03-19 08:20
Category: Computer
Tags: adb, computer 
Slug: adb-usage-at-work
Author: John Nduli
status: published

To use adb in archlinux, first install android-tools.

.. code:: bash
    
    sudo pacman -S android-tools

I then add the adb resources to the android rules files.
LIst packages installed

adb shell pm list packages -f

Get main activity of package
adb shell pm dump com.kokonetworks.android.fuelpointmanager | grep
-A 1 MAIN

Launch activities
adb shell monkey -p app.package.name -c
android.intent.category.LAUNCHER 1

db shell
am start -n com.package.name/com.package.name.ActivityName

specific action
am start -a com.example.ACTION_NAME -n
com.package.name/com.package.name.ActivityName

install apk
adb install -r filename.apk
