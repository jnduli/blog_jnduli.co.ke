##########################################
Moving home directory to another partition
##########################################


:date: 2022-04-22
:category: Computer
:slug: moving_home_directory_to_another_partition
:author: John Nduli
:status: draft

I'd need to install ubuntu on my work laptop, but I didn't want to lose my home
directory. The set up I'd made had everything in one partition, so my home
folder would get lost if I chose to reinstall an OS. I'd move the contents on
this folder into another partition.

I'd need to ensure I had enough space to pull this off. This meant that the new
partition would have to have at least the size of my home folder, and I found
this by running:

.. code-block:: bash

   cd /home
   du -sch $(ls -A)

I didn't have enough space, so I cleared up some space using instructions found
here (TODO: add link to article on space cleanup). I made sure I had the size of
my home dir + 50GB. I don't want to be unable to store new files there.

To partition the drive, I'd need the resize the current partition, and then
create a new partition from the unallocated space. I got the gparted iso, set it
up on a flash drive and booted into it. The GUI helped me shrink the drive and
create the new partition that I'd use as my home directory.

Once done, I logged into my original OS as the root user, mounted the new
partition and copied over my home folder with:


.. code-block:: bash

   mount /dev/sdc2 /mnt
   cp -rp /home/* /mnt # cp -r --preserve=all /home/* /mnt would work better
   mv /home /home.old


I got the uuid for the drive with `blkid`, and modified my `/etc/fstab` to
automatically mount this partition on boot as my home directory with:

.. code-block:: bash

    # home directory mount
    UUID=uuid_from_blkid_output 	/home     	ext4      	rw,relatime	0 2

I rebooted my laptop and everything seemed ok ok.

Lastly, I cleaned out the `home.old` folder with:

.. code-block:: bash

   rm -rf /home.old


And now I could safely change my OS without losing my home directory.
