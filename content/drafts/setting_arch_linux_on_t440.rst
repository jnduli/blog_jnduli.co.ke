#############################
Thinkpad T440 ArchLinux Setup
#############################
:date: 2021-02-18
:tags: linux
:category: Computer
:slug: thinkpad-t440-archlinux-setup
:author: John Nduli
:status: draft


I recently got a Thinkpad T440 and decided to document the steps I took
to set up archlinux. The last time I'd done this was on the `Asus
Zenbook UX330UA <{filename}/installing_arch_on_asus_zenbook.rst>`_ some
years back. I thought the process would be different, but it was largely
similar.

I first got the iso image and burnt it onto a flash drive with:

.. code-block:: bash

    sudo dd if=archlinux-2021.01.01-x86_64.iso of=/dev/sda status=progress bs=2M 

Connecting the flash into the laptop and booting got me into Grub, then
archlinux. Connecting to wifi, `iwctl
<https://wiki.archlinux.org/index.php/Iwd>`_ is the new recommended
method.

.. code-block:: bash

    iwctl
    device list # showed wlan0 as the wifi device
    station wlan0 scan
    station wlan0 get-networks # list SSIDs
    station wlan0 connect SSID


After connecting to wifi, I updated the system clock with:

.. code-block:: bash

    timedatectl set-ntp true

I had no qualms wiping out my hard drive and setting things up from
scratch. I noticed that I had two storage devices, a 16GB SSD and a 512GB
hard drive. I decided against using the SSD for anything (I'm planning
to upgrade this to a larger size), and just used the hard drive for
everything.

To partition the drive:

.. code-block:: bash

    fdisk -l # lists devices

    fdisk /dev/sda # enters fdisk to help modify this drive
    g # convert to gpt partitioning scheme
    n # create a new partition
    # first partition 2M for Grub
    n # 2nd partition 120GB for linux
    n # 3rd partittion rest of files size, for home directory

Key thing was to ensure I had the first partition of a size at least 1MB
for Grub (see `grub archwiki
<https://wiki.archlinux.org/index.php/GRUB#GUID_Partition_Table_(GPT)_specific_instructions)>`_.
I also went with another two partition: 120GB for arch and the rest for my
home folder. My reasoning was that when I upgraded the SSD, I'd just set
up arch on it and my home folder would still be ok.

I partitioned the 2nd partition with:

.. code-block:: bash

    mkfs.ext4 /dev/sda2
    mount /dev/sda2 /mnt

And installed most of the programs I'd need with:

.. code-block:: bash

    pacstrap /mnt base linux linux-firmware openssh git networkmanager tmux i3 dmenu sway xfce4 feh scrot xautolock python python-pip gvim neovim python-pynvim xdg-user-dirs zsh zsh-completions pulseaudio ledger firefox libmtp gvfs-mtp man-db man-pages texinfo intel-ucode grub

To generate fstab, I first mounted the third partition into `/mnt/home`:

.. code-block:: bash

    mkfs.ext4 /dev/sda3
    mount /dev/sda3 /mnt/home # ensures home is on another partition
    genfstab -U /mnt >> /mnt/etc/fstab

I then chroot'ed into the partition and set up my timezone, locale and
root user.

.. code-block:: bash

    arch-chroot /mnt
    ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime
    hwclock --systohc

I set the locale by uncommenting the 'en_US.UTF-8 UTF-8' and the
'en_GB.UTF-8 UTF-8' lines in the /etc/locale.gen file and ran:

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
uncommenting the line `%WHEEL  ALL= (ALL) ALL`.

.. code-block:: bash

    pacman -S sudo
    EDITOR=vi visudo #and uncommnet the line %WHEEL  ALL= (ALL) ALL

Lastly I set up grub with:

.. code-block:: bash

    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg

and after rebooting, I could enter into my system.

Other Thinkpad T440 specific Things
===================================
This section will keep getting updates as I slowly improve my linux
experience on the laptop.

I installed xorg using the instructions `xorg archwiki
<https://wiki.archlinux.org/index.php/Xorg>`_.

I had to fix the screen size by measuring my screen dimensions with a tape
measure and added them in a monitor config in
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
