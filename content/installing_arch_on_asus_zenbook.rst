####################################
ASUS ZenBook UX330UA ArchLinux Setup
####################################
:date: 2017-06-28 15:00
:tags: asus, archlinux, linux
:category: Computer
:slug: asus-zenbook-archlinux-setup
:author: John Nduli
:status: published

I recently got the ASUS ZenBook UX330UA-AH54, which is a really
awesome machine. I've been using it for one month now, and its
beautiful. 

So first thing I did with the laptop was install archlinux (dual
boot with windows). These are the steps I took to set up
archlinux. Most of these steps can be found in one form or another
on the `archlinux wiki <https://wiki.archlinux.org/>`_

Hard Drive Preparation
======================
I partitioned the hard drive using windows tools.

.. TODO add the instructions for windows

I then downloaded archlinux iso file in another machine that had
archlinux, and attached a flash drive. To setup the iso file, I
did this from the terminal:

.. code-block:: bash

    dd if=archlinux.iso of=/dev/sdb bs=4M status=progress

I then connected this flash drive to the Asus laptop and did a
reboot. When the Asus logo shows, I pressed <Esc> so that I could
choose which bootable media to use. I selected the flash drive and
unfortunately got the error:

.. code-block:: bash

    Invalid signature detected. Check secure boot policy in setup.

I then went to set up and disabled secure boot policy.

.. TODO add the steps for this

I successfully managed to enter the archlinux environment. I
verified uefi mode by using:

.. code-block:: bash

    ls /sys/firmware/efi/efivars

This gave me some content, thus it was fine.

Internet Connection
===================
I connected to the internet via wifi. To do this:

.. code-block:: bash

    iw dev #to get name of wireless interface. I got wlp2s0
    ip link set wlp2s0 up #I had to activate the kernel interface
    ip link show wlp2s0 #To check if activated. There was an UP between the <> info
    iw dev wlp2s0 scan | less #list wifi Access Points in area
    wpa_supplicant -i wlp2s0 -c <(wpa_passphrase "SSID" "keytoaccesswifi") -B #connect to wifi
    iw dev wlp2s0 link #to check if associated
    dhcpd wlp2s0 #to get up address from wifi


System Clock
------------
To update the system clock, I did:

.. code-block:: bash

    timedatectl set-ntp true
    timedatectl status # checks the time


Initial Setup
=============
To install arch, I had to view the partitions and the sizes so
that I could choose the correct one.

.. code-block:: bash

    fdisk -l

After getting the correct one:

.. code-block:: bash

    mkfs.ext4 /dev/sda4 #format partition as ext4
    mount /dev/sda4 /mnt #mount partition to start working with it

I then set up some basic packages for arch:

.. code-block:: bash

    pacstrap /mnt base base-devel

I generated the fstab:

.. code-block:: bash

    genfstab -U /mnt >> /mnt/etc/fstab

Now change into the new file system root:

.. code-block:: bash

    arch-chroot /mnt

I set the time zone for my system:

.. code-block:: bash

    ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime
    hwclock --systohc

For the time zone once '/user/share/zoneinfo' has been type,
clicking tab will autocomplete.

I set the locale by uncommenting the 'en_US.UTF-8 UTF-8' and the
'en_GB.UTF-8 UTF-8' lines in the /etc/locale.gen file and then
ran:

.. code-block:: bash

    locale-gen

To set the default locale, I create a file /etc/locale.conf and
added LANG=en_US.UTF-8 to it.

.. code-block:: bash

    echo LANG=en_US.UTF-8 >> /etc/locale.conf

The Hostnames file /etc/hosts was already existing so I did not
edit it.
I then set the root password by running:

.. code-block:: bash

    passwd


Bootloader installation
-----------------------

I first installed grub and efibootmgr.

.. code-block:: bash

    pacman -S grub efibootmgr


I needed parted so that I could know my ESP partition ( EFI system
partition).  The actual partition will have the name shown. So to
do this:

.. code-block:: bash

    sudo pacman -S parted
    parted /dev/sda print # to know which was my ESP partition


After getting the ESP partition, I mount /boot/efi onto it and
install grub.

.. code-block:: bash

    mount /dev/sda1 /boot/efi
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
    pacman -S intel-ucode #enabling microcode updates
    grub-mkconfig -o /boot/grub/grub.cfg

I then reboot the machine. I get an error at the login prompt but
it can be ignored.

User Creation
=============

To create a user:

.. code-block:: bash

    useradd -m -G wheel -s /bin/bash username
    passwd username

I then set up sudo on the laptop:

.. code-block:: bash

    pacman -S sudo
    EDITOR=vi visudo #and uncommnet the line %WHEEL  ALL= (ALL) ALL

The line containing "%WHEEL ALL= (ALL) ALL" is uncommented.

Window Managers and Other Applications
======================================

I first set up xdg-dirs, and the run xdg-user-dirs-update.
I then open the file .config/user-dirs.dirs and set the values to
how I want my home directory to be organised.

I then copy the /etc/xdg/user-dirs.code file to the .config folder
and set enabled to false.

I then create all my directories as pwer user-dirs.dirs manually using mkdir.

.. code-block:: bash

    sudo pacman -S xdg-user-dirs
    run xdg-user-dirs-update
    vi .config/user-dirs.dirs
    cp /etc/xdg/user-dirs.conf ~/.config/
    vi .config/user-dirs.conf #change enabled=False


I then install vim and tmux and configure it as per the `link <https://github.com/jnduli/dotfiles>`_ .

.. code-block:: bash

    sudo pacman -S gvim tmux

I also set up powerline fonts as found `here <https://github.com/powerline/fonts>`_ to help in vim_airline setup.

I then install zsh:

.. code-block:: bash

    sudo pacman -S zsh zsh-completions

And then setup oh-my-zsh as per the instructions `here: zshlink <https://github.com/robbyrussell/oh-my-zsh>`_

I then install xorg group, sfce4 and xfce4-goodies for one of my
desktop environments.

I also install i3 as my main window manager.

Other Installs
==============

.. code-block:: bash

    sudo pacman -S python python2 python-pip python2-pip
    sudo pacman -S kicad kicad-library kicad-library-3d
    sudo pacman -S openssh
    sudo pacman -S mtp gvfs-mtp 


I also use ledger to manage my finances so I have to install it.
Ledger is only found in AUR so I first installed yaourt from
instructions found `here :yaourt <https://archlinux.fr/yaourt-en>`_

After that I install ledger with:

.. code-block:: bash

    yaourt -S ledger

The following installs are requirement for my i3 config to work
properly:

.. code-block:: bash

    sudo pacman -S redshift feh scrot dmenu
    sudo pacman -S python-gobject python-xdg librsvg #required for redshift-gtk

For xfce4, I added the following shortcuts:

.. code-block:: bash

    exo-open --launch TerminalEmulator  Super+Return
    xfce4-terminal --drop-down F12

To switch capslock and escape, I added this to my .xinitrc:

.. code-block:: bash

    setxkbmap -option caps:swapescape

The audio by default was muted so to fix this I did the following:

.. code-block:: bash

    sudo pacman -S alsa-utils
    alsamixer
    #went to master and unmuted by pressing m

And with that I was comfortable enough with my archlinux setup.
