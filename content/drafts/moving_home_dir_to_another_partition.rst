##########################################
Moving home directory to another partition
##########################################


:date: 2022-04-22
:category: Computer
:slug: moving_home_directory_to_another_partition
:author: John Nduli
:status: draft


There was a chance that I'd have to install ubuntu on my laptop and I didn't
want to lose the content of my home folder. I'd create a new partition and put
the contents of my home folder there, that way changing of modifying my OS
wouldn't affect this.

I made sure I had enough space for this. I first found the size of my home
directory by running:

.. code-block:: bash

   cd /home
   du -sch $(ls -A)

I'd need to have at least that free space on my drive, so I did a bit of clean
up. I ensured I had a bit more free space than the size of my home directory. I
don't want to be unable to save new files there.

To partition the drive, I'd need to move things around so that the free space is
contiguous. I didn't want to use my host OS for this, so I set up gparted on a
drive and booted this. It provides a nice GUI that helped me shrink the drive,
and create a new partition that would host my home directory.

Once done, I logged into the host OS as the root user, mounted the new partition
and copied over the content of my home folder with:

.. code-block:: bash

   mount /dev/sdc2 /mnt
   cp -rp /home/* /mnt # cp -r --preserve=all /hom/* /mnt would work better
   mv /home /home.old


I got the uuid for the drive with `blkid`, and modified my `/etc/fstab` to
automatically mount this partition on boot as my home directory with:

.. code-block:: bash

    # home directory mount
    UUID=uuid_from_blkid_output 	/home     	ext4      	rw,relatime	0 2

I rebooted my laptop and everything went ok.

Lastly, I cleaned out the `home.old` folder with:

.. code-block:: bash

   rm -rf /home.old
