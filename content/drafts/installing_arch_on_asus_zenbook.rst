
Partitioned hard drive using windows tools.
Downloaded archlinux iso file and did:

    dd if=archlinux.iso of=/dev/sdb bs=4M status=progress

Connected flash to laptop and did a reboot.
Press esc when the asus logo shows, and choose the flash drive.
This caused an error message: Invalid signature detected. Check
secure boot policy in setup.
I then went to set up and disabled secure boot policy.
I then entered the archlinux environment.
I verified uefi mode by using ls /sys/firmware/efi/efivars and
found some content thus it was okay.


Connecting to the internet
I connected to the internet via wifi. To do this:

    iw dev # to get name of wireless interface. I got wlp2s0
    ip link set wlp2s0 up # i had to activate the kernel interface
    ip link show wlp2s0 # to check if activated. There was na UP
    between the <> info
    iw dev wlp2s0 scan | less # list wifi in area
    wpa_supplicant -i wlp2s0 -c <(wpa_passphrase "SSID"
    "keytoaccesswifi") -B
    iw dev wlp2s0 link # to check if associated
    dhcpd wlp2s0 # to get up address from wifi


TO update system clocK:

    timedatectl set-ntp true
    timedatectl status # checks the time

I then did fdisk -l to view the partitions I had create. I got the
one intended for installation by checking the sizes.

    mkfs.ext4 /dev/sda4
    mount /dev/sda4 /mnt

I then insalled some packages:

    pacstrap /mnt base base-devel

I generated fstab

    genfstab -U /mnt >> /mnt/etc/fstab

 I then changed root into the new system:

    arch-chroot /mnt

 I set the time zone

    ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime
    hwclock -systohc

I uncommented en_US.UTF-8 UTF-8 and en_GB.UTF-8 UTF-8 in the
/etc/locale.gen file and then ran:

    locale-gen

I created a file /etc/locale.conf and added LANG=en_US.UTF-8 to
it

Hostnames was already existing so I did not edit it.

I also set the root password with passwd


Bootloader installation
I had to install parted.
    
    pacman -S grub efibootmgr
    pacman -S parted
    parted /dev/sda print # to know which was my ESP partition
    mount /dev/sda1 /boot/efi
    grub=install --target=x86_64-efi --efi-directory=/boot/efi
    --bootloader-id=grub
    pacma -S intel-ucode
    grub-mkconfig -o /boot/grub/grub.cfg

Reboot the machine.
On reboot there is an error mesesage but I chose to ignore it.

Create a user:

    useradd -m -G wheel -s /bin/bash rookie
    passwd rookie

Installing sudo:

    pacman -S sudo
    EDITOR=vi visudo and uncommnet the line %WHEEL  ALL= (ALL) ALL

Install xorg group
Install xfce4 and xfce4-goodies

Install i3
Install firefox and chromium

Setting up xdg-dirs 
        
    sudo pacman -S xdg-user-dirs
    run xdg-user-dirs-update
    edit .config/user-dirs.dirs
    cp /etc/xdg/user-dirs.conf ~/.config/
    edit it and change enabled=False
    create all the directories as per user-dirs.dirs folders manually with mkdir

Installing python

    sudo pacman -S python python2 python-pip python2-pip

Installing vim and tmux
    sudo pacman -S gvim tmux
    THen I follow instructions from
    https://github.com/jnduli/dotfiles to set up my dotfile
    I also set up powerline fonts as found in link to vim_airline
    setup

Installing zsh
    sudo pacman -S zsh zsh-completions
    //setup oh my zsh
    sudo pacman -S curl wget
    //github page for ohmyzsh has instructions on how to install
    this
    //set up zshrc file from the dotfiles configs 
    chsh -l //lists all 
    chsh -s /path/to.shell

Installing yaourt
    instructions found at :https://archlinux.fr/yaourt-en

Having yaourt I can now install some other packagers:
    yaourt -S ledger

Fixing my Audio Problem
    I installed alsa-utils
    sudo pacman -S alas-utils
    alsamixer
    went to master and unmuted by pressing m

Other installs 
    sudo pacman -S kicad kicad-library kicad-library-3d

Added somw shortcuts to xfce4:
    exo-open --launch TerminalEmulator  Super+Return
    xfce4-terminal --drop-down F12

    REmoved bottom panel from xfce4

 Installed ssh
    sudo pacman -S openssh

 Installations required to work with my i3 config file
    sudo pacman -S redshift feh scrot dmenu
    sudo pacman -S python-gobject python-xdg librsvg #required for
    redshift-gtk

TO fix the capslock and escape switching, I added this to my
.xinitrc:
    
    setxkbmap -option caps:swapescape
