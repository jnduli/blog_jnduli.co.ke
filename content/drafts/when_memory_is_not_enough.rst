#########################
When Memory is not enough
#########################
:date: 2018-05-24 16:00
:tags: archlinux, linux
:category: Computer
:slug: when-memory-is-not-enough
:author: John Nduli

Sometimes you are doing a task on a computer, when it suddenly
freezes or an application crashes. This has occured to me
multiple times, most recently being installing tor using yaourt,
compiling a nodejs project and compiling hledger.

To fix this, one needs to increase the size of swap. Swap is the
portion of the hard disk that the OS will use when memory runs
out, like some form of virtual memory. It is usually existent on
most linux installations (You probably set one yourself), but you
can increase this to cater for this unique situation.

So to do this, first allocate some diskspace that will be used for
this task. This saves us this space and it cannot be used for any
other task. Afterwards change the ownership and permissions of the
allocated space, then set it up as a linux swap space and finally
enable it so that the OS can use it for swapping..

.. code-block:: bash

    sudo fallocate -l 10G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    swapon /swapfile

Then, you can run whatever task was failing/crashing. After the
task successfully runs, you might want to disable this new space.
To do that:

.. code-block:: bash

    swapoff -a
    rm -f /swapfile

The source for these commands is from the `archlinux_wiki <https://wiki.archlinux.org/index.php/Swap>`_
