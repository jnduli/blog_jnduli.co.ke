################################################
Fast Linux Setup - Adding Grub Menu[Insecure]
################################################
:date: 2019-10-19
:tags: linux
:category: Computer
:slug: fast-but-insecure-linux-setup-adding-grub-menu
:author: John Nduli
:status: published

I got the idea of setting this up from this `article on making linux
fast again
<https://linuxreviews.org/HOWTO_make_Linux_run_blazing_fast_(again)_on_Intel_CPUs>`_.
The problem was that I did not want to set up these flags on my default
grub menu entry. I also did not understand what risks I'd be exposing
myself to, but I could get their names by running:

.. code-block:: bash

    ls /sys/devices/system/cpu/vulnerabilities 

    # which gave me
    l1tf  mds  meltdown  spec_store_bypass  spectre_v1  spectre_v2

The quick fix for the former problem was to add another menu entry in
grub that had the `mitigations=off` flag. The easiest way I found for
this was to use `grub-customizer
<https://launchpad.net/grub-customizer>`_. I just copied the contents of
the default grub setup to another profile, added the extra flag and
named this to `Insecure ArchLinux`. Here's the configuration I used for
this menu entry (notice the `mitigations=off` added to the third last
line):

.. code-block:: bash

    load_video
    set gfxpayload=keep
    insmod gzio
    insmod part_gpt
    insmod ext2
    set root='hd0,gpt5'
    if [ x$feature_platform_search_hint = xy ]; then
      search --no-floppy --fs-uuid --set=root --hint-ieee1275='ieee1275//disk@0,gpt5' --hint-bios=hd0,gpt5 --hint-efi=hd0,gpt5 --hint-baremetal=ahci0,gpt5  37a42152-19b4-453a-81c7-50fddcecd9ff
    else
      search --no-floppy --fs-uuid --set=root 37a42152-19b4-453a-81c7-50fddcecd9ff
    fi
    echo	'Loading Linux linux ...'
    linux	/boot/vmlinuz-linux root=UUID=37a42152-19b4-453a-81c7-50fddcecd9ff rw  loglevel=3 quiet mitigations=off
    echo	'Loading initial ramdisk ...'
    initrd	/boot/intel-ucode.img /boot/initramfs-linux.img

To confirm this had succeeded, I just checked the contents of any file in the
vulnerabilities folder.

.. code-block:: bash

    cat /sys/devices/system/cpu/vulnerabilities/meltdown 
    # which shows
    Vulnerable

With this I have both options on my grub, the default safe linux
environment and one (should I feel my machine is slow on some task),
that is insecure but fast.
