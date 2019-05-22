#########################
When Memory is not enough
#########################
:date: 2018-05-31 16:00
:tags: linux, server
:category: Computer
:slug: when-memory-is-not-enough
:author: John Nduli
:status: published

A computer or server suddenly freezes or crashes. You don't know
what the problem is and you really need to complete this task. One
of the options is to consider memory. You might have just run out.
To confirm this, you can monitor memory usage using the htop
command while the operation is running. This has occured to me
multiple times, most recently while installing tor using yaourt,
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

To improve performance, one can try to experiment with the virtual
memory subsystem. More on this can be found in the documentation
for `vm
<https://www.kernel.org/doc/Documentation/sysctl/vm.txt>`_. For
example, I tried this:

.. code-block:: lua

    sudo sysctl vm.swappiness=10
    sudo sysctl vm.vfs_cache_pressure=50

To make the changes permanent, one can try this:

.. code-block:: bash

    sudo cp /etc/fstab /etc/fstab.bak #create backup just in case something fails
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
    echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf


The source for these commands is from the `archlinux_wiki <https://wiki.archlinux.org/index.php/Swap>`_
