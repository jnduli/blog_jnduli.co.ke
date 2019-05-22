###############
GRUB RESCUE FiX
###############

:date: 2017-09-21 15:00
:tags: linux
:category: Computer
:slug: grub_rescue_fix
:author: John Nduli
:status: published

So I found myself in windows some time this week, and it started
updating. The process had one major consequence, grub could not
discover my linux partition, and so brought me to a prompt
containing 'grub_rescue'.

To fix this, I first did:

.. code-block:: bash

    ls


This will show a list of the partitions of my hard drive,
something like:

.. code-block:: bash

    (hd0) (hd0,gpt2) (hd0,gpt3) (hd0,gpt4)

I needed to get the partition with my linux on it. So to do this I
did:

.. code-block:: bash

   ls (hd0,gpt2)/
   ls (hd0,gpt3)/

While doing this, I was looking for a partition that has folders
similar to those in root. So when I got a partition that has
bin, boot, home, lib, etc in it, I knew I had got the correct one.

Assuming its (hd0,gpt3), I then did:

.. code-block:: bash

   set root=(hd0,gpt3)
   set prefix=(hd0,gpt3)/boot/grub
   insmod normal
   normal

With this, I was able to load the normal grub menu and boot into
archlinux.

Tox this permanently:

.. code-block:: bash

    mount /dev/sda1 /boot/efi
    sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg

This is just from my steps on installation of archlinux on my asus
laptop found `here <{filename}/installing_arch_on_asus_zenbook.rst>`_
