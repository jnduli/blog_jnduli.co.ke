Plan:

- Set up VM using light weight ubuntu
- Set up guix
- Set up python and attempt to use this
- Research setting up i3 using guix
- Research how to manage dotfiles using guix



Virtual Box Setup:
- New, add name (don't use Expert Mode)
- memory size: if 8GB of Ram, do 3Gg, if you have 15GB, set 4 or 5.
- hard disk set up: create a virtual disk, create, use VDI
  dynamically allocated is slower, so prefer fixed size.
  For size, do like 10GB.
- Modify settings i.e. right click image and click on settings.
    - general -> advanced: enable shared clipboard in bidirectinal way.
    - system -> processor: change to half no of vcpus - 1
            extended features: enable PAE/NX and nexted VT/AMD if available
    - acceleration: leave things checked
    - dispay -> screen: max out video memory and enable 3d acceleration
    - set up shared folders: helps copy folders between host and VM and
      automount
- set up guest additions:
    - install gcc, perl, make: sudo apt install gcc make perl
    - go to devices > insert special additions cd/rom, this will restart some
      prompt and after you add your passwords insert kernel modules for you.
- restart kernel
    



Guix installation: https://guix.gnu.org/manual/en/html_node/Binary-Installation.html

.. code-block:: bash

    cd /tmp
    wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
    chmod +x guix-install.sh
    ./guix-install.sh

    # Not tested, from:
    # Step by step guide: https://www.ubuntubuzz.com/2021/04/lets-try-guix.html

    guix pull

    # this section doesn't work, research the latest for this from official guix docs
    # Look here for details: https://guix.gnu.org/en/manual/devel/en/html_node/Binary-Installation.html#Binary-Installation
    GUIX_PROFILE="$HOME/.guix-profile"
    . "$GUIX_PROFILE/etc/profile"

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
