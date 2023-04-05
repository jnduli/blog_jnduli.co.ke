
Other useful commands that can help are:

.. code-block:: bash


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

