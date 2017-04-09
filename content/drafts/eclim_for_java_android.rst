Installation of Eclim
^^^^^^^^^^^^^^^^^^^^^

Download eclim, and run as per website instructions
http://eclim.org/install.html

After downloading eclim, I ran:
java -jar eclim_2.6.0.jar


To start it, get path where it is installed
Mine is:
~/.eclipse/org.eclipse.platform_4.6.2_155965261_linux_gtk_x86/eclimd

TO confirm it has started, do this in vim:
    PingEclim

To close it from vim:
    :ShutdownEclim

Or do this:
~/.eclipse/org.eclipse.platform_4.6.2_155965261_linux_gtk_x86/eclimd
-command shutdown

Create a project
^^^^^^^^^^^^^^^^

:ProjectCreate path -n java
:ProjectCreate path -n android

:ProjectTree
:ProjectLIst
:ProjectDelete


Usage of Java
^^^^^^^^^^^^^
:Java - to compile the code

Usage on Android
^^^^^^^^^^^^^^^^
From terminal

android update project -p /path/project -n name

If android is not recognized, do
/path/to/android/sdk/tools/android update project 

Then do:
:Adb debug install
Then use adb to install the application

Since I'm doing all this because I still have a 32 bit machine,
here are some more tools:
Then android debug tools I use are:

    - Android SDK Build Tools 23.0.1

If all fails to install:
    Run ant clean in folder,
    then run adb debug install
