#############################
Asus Zenbook Issues Fix On i3
#############################

Keyboard backlight fix
=======================

https://wiki.archlinux.org/index.php/Keyboard_backlight

THe link has a file called kb-light.py. I set up this file in
/usr/local/bin.

I then opened my i3config file and added the following:

bindsym XF86KbdBrightnessUp exec python /usr/local/bin/kb-light.py +
bindsym XF86KbdBrightnessDown exec python /usr/local/bin/kb-light.py - 

And now when I press the keyboard brightness up and down key, the
keyboard lights change as expected.

Screen brightness fix
=====================

For this I wanted to use xbacklight. THe problem I got was that
when I tried 
    xbacklight -inc 10

I got the error "No outputs have backlight propery". 

To fix this, I installed the intel driver 
    
    sudo pacman -S xf86-video-intel

And after rebooting it worked well.
So to set up the keyboard keys, I added this:

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 10 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 10 # decrease screen brightness

Media Keys Usage Fix
====================
For this, I first had to install pulseaudio.
    sudo pacman -S pulseaudio

Then I added this to my i3 config files:
# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound





