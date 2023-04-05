############
Testing GUIX
############

:date: 2023-03-31
:category: Computer
:slug: testing_guix
:author: John Nduli
:status: published


I installed guix with:

.. code-block:: bash

    # Install nscd (name service cache daemon) to help pick up guix libs
    sudo apt install nscd
    sudo systemctl enable nscd

    # install guix
    # Ref: https://guix.gnu.org/manual/en/html_node/Binary-Installation.html
    cd /tmp
    wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
    chmod +x guix-install.sh
    sudo ./guix-install.sh

    # update guix
    guix pull

    # log out and in again
    # confirm guix-daemon is running with:
    ps aux | grep -i guix

    #  installing guix locales, used by libc installed via guix
    guix install glibc-locales

    # ensures guix libs and apps can do https
    guix install nss-certs

    # Add the following to .profile
    GUIX_PROFILE="$HOME/.guix-profile"
    GUIX_LOCPATH=$GUIX_PROFILE/lib/locale
    . "$GUIX_PROFILE/etc/profile"

I like i3 window manager and the ubuntu provided version doesn't yet support
gaps. I installed i3 using the ubuntu package manager (apt), which configured
the login manager for i3 in `/usr/share/xsessions/`. I then installed i3-gaps
using guix and it had preference to the i3 installed via apt.

.. code-block:: bash

   sudo apt-install i3
   guix install i3-gaps

I set up fonts using:

.. code-block:: bash

    guix install fontconfig
    fc-cache -rv

and installed other useful packages:

.. code-block:: bash

    # installing my editor
    guix install python neovim python-pynvim git


I update my guix system using:

.. code-block:: bash

    guix pull
    guix package -u


I needed to install neovim that was build with a later version of the gcc-tool
chain. I solved this with:

.. code-block:: bash

    guix package -i neovim --with-c-toolchain=tree-sitter=gcc-tool-chain@12.2
