#############################
Thinkpad T440 ArchLinux Setup
#############################
:date: 2021-02-18
:tags: linux
:category: Computer
:slug: thinkpad-t440-archlinux-setup
:author: John Nduli
:status: drafts


It's been a while since I set up arch on a laptop. I recently got a
Thinkpad T440 and decided to document the process with it. I'd previous
written about setting arch on Asus Zenbook some time back, and
surprisingly the information was still mostly relevant and a help for
me.

I first got the iso image and burnt it onto a flash drive with:

.. code-block:: bash

    sudo dd if=archlinux-2021.01.01-x86_64.iso of=/dev/sda status=progress bs=2M 

Connecting the flash into the laptop immediately entered into Grub, then
archlinux. Connecting to wifi, I used `iwctl`.

.. code-block:: bash

    iwctl
    device list # showed wlan0 as a device
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect SSID


I then updated the system clock with:

.. code-block:: bash

    timedatectl set-ntp true

I then needed to partition my drives. I had two drives, a 16GB SSD and a
512GB hard drive. I decided against using the SSD for anything for the
moment, and just progressed with the hard drive.

.. code-block:: bash

    # partition disks
    fdisk -l

    fdisk /dev/sda
    g # convert to gpt partitioning scheme
    n # create a new partition
    # first partition 2M for Grub
    # 2nd partition 120GB for linux
    # 3rd partittion rest of files size
    n # create another partition, that took rest of remaining space

Key thing was to ensure I had the first partition of a size at least 1MB
for Grub. I also went with two partition sizes: 120GB for arch and the
rest for my home folder. My reasoning was that if I ever wanted to
upgrade the SSD, I could just set up arch in that and things would be
smoothly set up.

I then partitioned the 2nd partition with:

.. code-block:: bash

    mkfs.ext4 /dev/sda2
    mount /dev/sda2 /mnt

And installed most of the programs I'd need with:

.. code-block:: bash

    pacstrap /mnt base linux linux-firmware openssh git networkmanager tmux i3 dmenu sway xfce4 feh scrot xautolock python python-pip gvim neovim python-pynvim xdg-user-dirs zsh zsh-completions pulseaudio ledger firefox libmtp gvfs-mtp man-db man-pages texinfo intel-ucode grub

To generate fstab, I first mounted the third partition into `/mnt/home`:

.. code-block:: bash

    mount /dev/sda3 /mnt/home # ensures home is on another partitions
    genfstab -U /mnt >> /mnt/etc/fstab

I then chroot'ed into the parition and set up some things:

.. code-block:: bash

    arch-chroot /mnt
    ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime
    hwclock --systohc

I set the locale by uncommenting the 'en_US.UTF-8 UTF-8' and the
'en_GB.UTF-8 UTF-8' lines in the /etc/locale.gen file and then ran:

.. code-block:: bash

    locale-gen
    echo LANG=en_US.UTF-8 >> /etc/locale.conf
    echo ovonel >> /etc/hostname

and added the following lines into `/etc/hosts`:

.. code-block:: txt

    127.0.0.1 	localhost
    ::1		localhost
    127.0.1.1	ovonel.localhodmain ovonel

I set up the root password by typing `passwd`, and added a new user
with:

.. code-block:: bash

    useradd -m -G wheel -s /bin/bash username
    passwd username

I also installed sudo and set up permissions for the wheel group by
uncommenting the linke `%WHEEL  ALL= (ALL) ALL`.

.. code-block:: bash

    pacman -S sudo
    EDITOR=vi visudo #and uncommnet the line %WHEEL  ALL= (ALL) ALL

Lastly I set up grub with:

.. code-block:: bash

    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg

and after rebooting, I could enter into my system.

Setting Things Up Later
=======================
I'll be working on this section as I figure out the things I need to set
up and work with.

I installed xord using the instructions `in archlinux xord <https://wiki.archlinux.org/index.php/Xorg>`_

And had to fix the screen size by measuring my dimensions with a tape
measure. I added the dimensions in a monitor config in
`/etc/X11/xorg.conf.d/90.monitor.conf`:

.. code-block:: txt

    Section "Monitor"
        Identifier 	"eDP1"
        DisplaySize 	300 170
        Gamma		0.7
    EndSection

For power management I set up tpacpi-bat and enabled the default
mappings:

.. code-block:: lua

    sudo pacman -S tpacpi-bat 
    sudo systemctl enable tpacpi-bat.service


TODO:
- add references
