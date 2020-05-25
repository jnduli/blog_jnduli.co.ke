####################################
Freeing up Space in my Linux Machine
####################################

:date: 2018-08-26 16:00
:tags: linux
:category: Computer
:slug: freeing-up-space-in-linux-machine
:author: John Nduli
:status: published

I have a 256GB SSD on my laptop. This is rather constrained and I
occasionally end up with less than 10GB drive space. When this happens,
I have to figure out what is taking up all my space and fix this. This
prompts some form of search and cleaning up of the culprits. This
article lists the process and commands I usually run for this to
happen.

To get a general feel of how much space I have:

.. code-block:: bash

   df -h

Some sample output from this command is:

.. code-block:: bash
   
   Filesystem      Size  Used Avail Use% Mounted on
   dev             3.9G     0  3.9G   0% /dev
   run             3.9G  1.4M  3.9G   1% /run
   /dev/sda5       106G   93G  7.4G  93% /
   tmpfs           3.9G  132M  3.8G   4% /dev/shm
   tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
   tmpfs           3.9G  8.0K  3.9G   1% /tmp
   /dev/sda6        41G   20G   21G  50% /run/media/silo
   tmpfs           787M   20K  787M   1% /run/user/1000


This provides key information like what is the size of a partition and
how much space has been used up. The '-h' tag helps in making the sizes
easier to read.

To list the various folders in root folder '/' and
their sizes, I use:

.. code-block:: bash

   du -sch /* | sort -h

If permissions become a problem, you can run it with
sudo.

.. code-block:: bash

   11G     /var
   14G     /opt
   20G     /run
   33G     /home
   36G     /usr
   113G    total

The above shows part of the output of the above command. You can
change the folders as you try to figure out what is consuming
space.

The `du` command ignores files and folders that start with
a '.'. This can become troublesome because it will not give you
enough information about what is consuming space especially in the
home directory, which in my case is riddled with such. To fix that,
run this command instead:

.. code-block:: bash

   du -sch .[\!.]* * | sort -h

This will scan all folders including those that start with a '.'.
However it returns results of the current folder one is in. A more
generic one is:

.. code-block:: bash

   du -sch /folder/path/[\!.]* * | sort -h

The `ls` command is another alternative for finding the sizes of files:

.. code-block:: lua

   ls -lah

Using the above commands, a general idea of where and how disk space is
used can be formed.


Cleaning Disk Space
===================
Clearing up the cache of whatever installer I'm using is usually a good
place to start:

.. code-block:: bash

   sudo pacman -Scc
   sudo yay -Scc

Some installed packages take up a log of space. This command (found `here
<https://www.commandlinefu.com/commands/view/7613/arch-linux-sort-installed-packages-by-size>`_)
lists packages from the smallest to the largest.

.. code-block:: bash

   pacman -Qi | grep 'Name\|Size\|Description' | cut -d: -f2 | paste - - - | awk -F'\t' 'BEGIN{ s["MiB"]=1024; s["KiB"]=1;} {split($3, a, " "); print a[1] * s[a[2]], "KiB", $1}' | sort -n

You can also remove orphans. To find them:

.. code-block:: bash

    sudo pacman -Qtd

Look through the list and remove what is not needed. To remove all
orphans:

.. code-block:: bash

    sudo pacman -Rns $(pacman -Qtdq)

Delete unnecessary files that are hogging up space. These can be found
using the `dh` or `ls` commands and deleted using:

.. code-block:: bash

   rm file
   rm -r directory

Another huge disk space hog is my cache folder. I typically delete this
folder using:

.. code-block:: bash

    rm -r ./cache/*

But if you want to be safe, you can delete only the files in that folder
that haven't been used in a year using:

.. code-block:: bash

    find ~/.cache/ -type f -atime +365 -delete

I use docker a lot. So it tends to eat up a lot of disk space. The
following commands help me out here:

.. code-block:: bash

   sudo docker system df -v
   sudo docker system prune
   sudo docker volume prune

Without the '-v' option, the command offers a summary of the
disk space used by docker.

To deal with containers, I use the following commands:

.. code-block:: bash

   sudo docker ps -a
   sudo docker rm NAME

The first command will list all containers and the second command
deletes containers based on their name.

To deal with images, I first list all the images with:

.. code-block:: bash

   sudo docker images -a

I usually like deleting the images with no tags. To that I run the
folloing command:

.. code-block:: bash

   sudo docker images | grep \<none\> | awk '{print $3}' | xargs sudo docker rmi

With this I can effectively remove files until I feel comfortable
with the remaining disk space.
