############
Testing GUIX
############

I was required to use ubuntu and I wasn't sure I'd replicate my current set up
there. I also wanted a reproducible build, so I looked into guix as a package
manager and like it.

I first set up a VM with VirtualBox and installed xubuntu. The set up follows
this video: https://www.youtube.com/watch?v=qL3xc8hwU7c

- Open Virtual Box, select New and add a descriptive name.
- Make sure Expert Mode is disabled, then click Next
- Set memory size to 3GB
- Preallocate hard disk space. Avoid dynamically allocated since it'll be
  slower. Use VDT to create the virtual disk and I used 25GB space.
- After image is created, modify more settings.
    - general -> advanced: enable shared clipboard in bi-directional way.
    - system -> processor: change to total number of vcpus/2 - 1
    - display -> screen: max out video memory and disable 3d acceleration
    - set up shared folders: helps copy folders between host and VM and
      auto-mount
- set up guest additions:
    - install gcc, perl, make: `sudo apt install gcc make perl`
    - go to devices > insert special additions cd/rom, this will restart some
      prompt and after you add your passwords insert kernel modules for you.
- restart kernel

I installed guix with:

.. code-block:: bash

    cd /tmp
    wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
    chmod +x guix-install.sh
    ./guix-install.sh

    guix pull

    #  installing guix locales, used by libc installed via guix
    guix install glibc-locales
    export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

    # TODO: add the above to .profile 

    # Install nscd (name service cache daemon)
    sudo apt install nscd
    sudo systemctl enable nscd
    
    # TODO: set this up in .profile folder
    GUIX_PROFILE="$HOME/.guix-profile"
    . "$GUIX_PROFILE/etc/profile"

I like i3 as my window manager and the ubuntu provided version doesn't yet
support gaps. I first install i3 using the ubuntu package manager, setting up
the correct configs to be picked up by the login manager in
`/usr/share/xsessions/` and then install i3-gaps using guix. `i3-gaps` will have
preference to the i3 installed via the system package manager.

.. code-block:: bash

   sudo apt-install i3
   guix install i3-gaps

Font set up:

.. code-block:: bash

    guix install fontconfig
    fc-cache -rv




Install other packages:

.. code-block:: bash
    # installing my editor
    guix install python neovim python-pynvim

    guix install nss-certs # so that I can use git
    guix install git

Other useful commands that can help are:

.. code-block:: bash

    # log out and in again
    # confirm guix-daemon is running with:
    ps aux | grep -i guix

    # helper commands
    guix describe
    guix package --list-installed 

    guix search [keyword] e.g. guix search text editor
    guix install packagename
    guix size packagename

    # guix has generations which are like commits in git. When I add /remove a
    # program I do a commit, and I can move back in time to previous generations
    guix package --list-generations
    guix package --switch-generation
    guix package --roll-back

    # TODO: continue from Play CheckPoints location: https://www.ubuntubuzz.com/2021/04/lets-try-guix.html


Another tutorial to follow: https://gricad-doc.univ-grenoble-alpes.fr/en/hpc/softenv/guix/


Guix installation: https://guix.gnu.org/manual/en/html_node/Binary-Installation.html
