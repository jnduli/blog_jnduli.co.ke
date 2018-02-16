###############
SSH AND SERVERS
###############

:date: 2018-02-16 15:00
:tags: linux, server, computer
:category: Computer
:slug: ssh-and-servers
:author: John Nduli
:status: draft

SSH provides a secure means of remote login to another computer.
When setting up linux servers, it is usually provided by the OS.
The default means of loggin in is by:

.. code-block:: bash

    ssh user@ipaddress

This prompts for a password, after which you have access to a
remote terminal. However, this is not really secure as someone can
try to guess the password. A better method is to set up ssh-keys
on the server, and disable password login. This means that someone
can only access your server if they have the private ssh-key.

To generate a key:
    
.. code-block:: bash

    ssh-keygen -t rsa -b 4096 -C 'comment'

There will be some prompts that guide you through the process. To
set up the default key that will be used, save this in the default
file suggested. Otherwise, you can save it to a custom location.
Care should be taken, especially if you already had another ssh
key, because you can easily override this. The command generates
to file, the private key and a public key ( has a .pub suffix).

To set up the key in a server, do:

.. code-block:: bash

    ssh-copy-id user@ipaddress -i file.pub

If you are copying the keys found in the default location i.e.
~/.ssh/id_rsa.pub, the -i option can be ignored.

Having set the key up on the server, you can log in using:

.. code-block:: bash

    ssh -i /path/to/privatekey user@ipaddress

If using the default file location, the -i option can be ignored.

To disable the password login option, log into the server and
edit the /etc/ssh/sshd_config file (to disable password access for
the server) or ~/.ssh/config file (to disable password access for
a specific user). The following line should be added to the file:

.. code-block:: bash

    PasswordAuthentication no

After this, restart ssh using:

.. code-block:: bash

    reload ssh


SSH Forwarding
==============
SSH forwarding is where the private key used to login to the
server, can be used by the server to perform some tasks. This is
useful in CI/CD, or when working with git on some server.

To enable this, edit the ~/.ssh/config file from the locatl
machine and add:

.. code-block:: bash

    Host example.com
        ForwardAgent yes

To set up the key for use by the server:

.. code-block:: bash

    eval $(ssh-agent)
    ssh-add ~/.ssh/key

Eval sets environment variables to ouput of ssh-agent. To confirm
the key has been added, you can do:

.. code-block:: bash

    ssh-add -L

When you connect to the server example.com, it will now have you
private sshkey in its environment and can be used to access
repositories, other servers, etc.

Frozen ssh session
==================

Sometimes after connecting to the server, the internet connection
is lost or your computer sleeps. The ssh prompt after this will be
frozen, with no commands running. To fix this, you have to leave
the prompt and log in again to the server. To do this, press the
following keys in order from the prompt:

.. code-block:: bash

   Enter
   ~
   .


