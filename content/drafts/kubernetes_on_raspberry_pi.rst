##########################
Kubernetes on Raspberry Pi
##########################

:date: 2019-12-22
:tags: project
:category: Linux
:slug: kubernetes-on-raspberry-pi
:author: John Nduli


`Kubernetes <https://kubernetes.io/>`_ is an open-source system for
automating deployment, scaling, and management of containerized
applications. `K3S <https://k3s.io/>` is a light-weight version of
kubernetes that can run on weak hardware e.g raspberry pi, and provides
most of the functionality of kubernetes.

I had three raspberry pis from previous projects (one v2 and two v3s)
lying around, so I decided to set up kubernetes and try it out. I used
raspbian buster lite as the linux version on all the raspberry pis. The
base command to set this up on my sd cards was:

.. code-block:: bash

    sudo dd if=rasbian-buster-lite.img of=/dev/sdb bs=1M status=progress

For each of the pis, I enabled wifi and ssh (in the interface setting)
using the `raspi-config` command. However, I had some problems with the
pi v2 because I used an external USB dongle for wifi. I found tips on
how to fix this on `saitetu's blog here
<https://saitetu.net/en/entry/2019/09/15/001352>`_.

.. code-block:: bash

    # add these lines to /etc/network/interfaces
    allow-hotplug wlan0
    iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    # then enable wpa_supplicant in systemd with 
    sudo systemctl enable wpa_supplicant.service

    
I also changed the hostname on each of the pi's to reflect their roles.
In my case I had:

.. code-block:: bash

    pi-master
    pi-node1
    pi-node2

This is useful because when sshing into the pis, one can just use the
hostname instead on the ip addresses (which are difficult to remember).
This is because raspbian has avahi mdns stack installed. However, for my
archlinux setup, I had to set `avahi up to work
<https://wiki.archlinux.org/index.php/Avahi>`_.


.. code-block:: bash

    sudo pacman -S avahi nss-mdns
    sudo systemctl start avahi-daemon.service # replace start with enable for this to always work

This allows me to ssh into the pi's via their hostnames instead of their
ip addresses e.g.

.. code-block:: bash

    ssh pi@pi-master.local

To setup my kubernetes master, I just ran this command in one of the
pis:


.. code-block:: bash

    curl -sfL https://get.k3s.io | sh -

To set up the kubernets nodes, the command is of the general form:


.. code-block:: bash

    curl -sfL https://get.k3s.io | K3S_URL=https://master_ip:6443 K3S_TOKEN=master-token sh -

I tried using the `mdns` name for the master_ip e.g. pi-master.local,
but this did not work for me. So I got the master's ip by running :code:`ip
address show`. 

To get the master-token, run :code:`cat
/var/lib/rancher/k3s/server/node-token1`.

Another useful option is to change permissions of the `k3s.yaml` file so
that you don't have to run kubernetes commands with escalated permission.

.. code-block:: bash

  sudo chmod 644 /etc/rancher/k3s/k3s.yaml


TODO:

- Include various kubectl commands and their outputs
