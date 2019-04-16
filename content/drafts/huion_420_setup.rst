Install llinux headers:

sudo pacman -S linux-headers


Install the digimend drivers using: 

 yay -S digimend-kernel-drivers-dkms-git


Enable this manenos using:

sudo modprobe -r hid-kye hid-uclogic hid-polostar hid-viewsonic

The default operations werent to my liking so I decided to use the wacom
tablet thing:

sudo pacman -S xf86-input-wacom

Config file:

Section "InputClass"
	#Identifier "ELAN1300:00 04F3:3028 Touchpad"
	Identifier "Huion on wacom"
	MatchProduct "HUION"
	MatchDevicePath "/dev/input/event*"
	Driver "wacom"
EndSection

Restart laptop and do:

xsetwacom --list
HUION 420 Pad pad                       id: 21  type: PAD
HUION 420 Pen stylus                    id: 22  type: STYLUS

Edit pressure using gimp tool.

References:
https://github.com/DIGImend/digimend-kernel-drivers
https://wiki.archlinux.org/index.php/Wacom_tablet
