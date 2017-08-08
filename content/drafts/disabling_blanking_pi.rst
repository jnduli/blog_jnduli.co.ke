Blanking is whereby a screen just goes blank (i.e. black screen).
This usually happens after some time of no usage on the raspberry
pi which is about 15 minutes.

This can sometimes become frustrating especially if it is a screen
set up for monitoring something.

So to disable it temporarily:

    xset s off # disables screen saver
    xset -dpms #disable power management settings
    xset -s noblank

TO disable it permanently:

    sudo vi /etc/lightdm/lightdm.conf

    THen add the followoing line:

    xserver-command=X -s 0 -dpms
