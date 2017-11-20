#########################################
Using Pass - A Password Manager/Generator
#########################################


:date: 2017-11-16 14:00
:tags: linux
:category: Computer
:slug: password-manager-pass
:author: John Nduli
:status: published

Pass is a password manager that stores passwords locally on the
host machine. Since the passwords are stored locally there is
minimal risk on your passwords being exposed after some data
breach occurring. Also, you can use git to version control the
passwords, and set them up in a repo on any machine.

To install:

.. code-block:: bash

   sudo pacman -S pass

Then to initialize the password store:

.. code-block:: bash

    pass init email

To insert a password into the store:

.. code-block:: bash

    pass insert /email/email@dns.com

If you get  the following error:

.. code-block:: bash

    gpg: email@dns.com: skipped: No public key
    gpg: [stdin]: encryption failed: No public key
    Password encryption aborted.

Then you have to first generate the gpg keys:

.. code-block:: bash

    gpg --full-gen-key

This will take you through the process step by step. All someone
has to do is follow the prompts.

To generate a password, do:

.. code-block:: bash

    pass generate name/of/service 10

which will generate a password 10 characters long

.. code-block:: bash

    pass -n generate name/of/service 10

will generate password without special symbols i.e. only
alphanumeric characters.

To edit or overwrite password

.. code-block:: bash

    password edit name/of/service or pass inserte

Other commands include:

.. code-block:: bash

    pass name/of/service # displays the password
    pass -c name/of/service # copies the password to xclip

    pass rm name/of/sercie # removes password
    pass rm -r name # removes full directory

    pass git init # sets up git in pass folder

To find out more about pass, you can check `here <https://www.passwordstore.org/>`_
