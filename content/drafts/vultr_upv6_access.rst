#####################################
ipv6 SSH when ISP provides no support
#####################################

:date: 2010-01-04
:category: Computer
:slug: ipv6-ssh-isp-no-support
:author: John Nduli
:status: drafts

I wanted a cheap VPS that I could use to test out various ops things I
learnt e.g. ansible. Vultr provides a $2.5 droplet, which fit my budget.
However, this droplet supports ipv6 addresses, with an additional cost
of $3/month for ipv4 addresses (which did not make sense).

The problem with ipv6 is that it isn't well supported in Kenya. All ISPs
I tried could not access the server, providing a `Network is
unreachable` error when I tried to ping my server. Other alternatives to
test for ipv6 suport include:

.. code-block:: bash
    
    ping -6 ipv6.google.com

or visiting `ipv6-test <https://ipv6-test.com/>`_.

A fix around this is to use a service that will tunnel an ipv4 address
to an appropriate ipv6 address. `Tunnebroker
<https://tunnelbroker.net/>`_ is a free service that provides this.

After setting tunnel broker up, I got the config to use by looking at
the `linus-route2` option. Following the resources on `archlinu
<https://wiki.archlinux.org/index.php/IPv6_tunnel_broker_setup>`_, I set
this up as a systemd service.

TODO: add config file for the systemd service
TODO: if I find fix for ipv4 access on the server, include it here
