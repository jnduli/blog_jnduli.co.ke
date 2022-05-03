##########################################
Moving home directory to another partition
##########################################


:date: 2022-04-30
:category: Computer
:slug: moving_home_directory_to_another_partition
:author: John Nduli
:status: published

I'd need to set up ubuntu, but I didn't want to lose my home directory.
Everything was in one partition, so I'd lose my home folder with a re-install. I
didn't want this, so I moved it into another partition.

The new partition would be the size of my home folder at least, and I
found this by running:

.. code-block:: bash

   cd /home
   du -sch $(ls -A)

I didn't have enough space, so I cleared up some space using `these instructions
<{filename}freeing_up_hard_drive_space_in_linux.rst>`_. I made sure the free
space was equal to m home directory + 50GB. I don't want to be unable to store
new files.

I resized (shrunk) the current partition, then created the new partition from
the unallocated space. I used `gparted live usb
<https://gparted.org/livecd.php>`_ for this. It's easy to use the GUI tool to
shrink and create new partitions.

Once done, I logged into my original OS as the root user, mounted the new
partition and copied over my home folder with:


.. code-block:: bash

   mount /dev/sdc2 /mnt
   cp -rp /home/* /mnt # cp -r --preserve=all /home/* /mnt might be better
   mv /home /home.old


I got the uuid for the new partition with `blkid`, and modified my `/etc/fstab`
to automatically mount this partition on boot as my home directory with:

.. code-block:: bash

    # home directory mount
    UUID=uuid_from_blkid_output 	/home     	ext4      	rw,relatime	0 2

I rebooted my laptop and everything seemed ok.

Lastly, I cleaned out the `home.old` folder with:

.. code-block:: bash

   rm -rf /home.old


And now I could safely change my OS without losing my home directory.
