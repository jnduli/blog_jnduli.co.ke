###########################
Setting and Using Mercurial
###########################

:date: 2018-06-08 09:00
:tags: linux
:category: Computer
:slug: setting-and-using-mercurial
:author: John Nduli
:status: draft

I've always wanted to use mercurial.

Set it up both on the server and my laptop:

.. code-block:: bash

    sudo pacman -S mercurial
    sudo apt install mercurial
    
Create a new repo on the server with:
    
.. code-block:: bash

    cd /path/to/hg/repo
    hg init trial

On the local machine, I use ssh to clone from the server.

.. code-block:: bash

    hg clone ssh://user@example.com:3300/path/to/hg/repo/trial

This adds the link as the default remote repo. It can be viewed by
doing:

.. code-block:: bash

    hg paths

And we get this:

.. code-block:: bash

    default = ssh://email@example.com/path/to/hg/trial

Basic usage commands:

.. code-block:: bash

    hg status
    hg add <file_name>
    hg commit -m "message"

If you did not set up the repository on the server before creating
the local repo, you can solve this by doing this:

Edit the .hg/hgrc file and add the following:

.. code-block:: python

    [paths]
    default = ssh://random@example.com/path/folder

    [ui]
    username = name <email@example.com>

Also make sure the server has this folder and that its set up

.. code-block:: bash

   mkdir /path/to/hg/folder
   cd /path/to/hg/folder
   hg init
