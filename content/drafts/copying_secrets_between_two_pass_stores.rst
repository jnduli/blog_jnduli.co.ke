#######################################
Copying Pass Secrets to Another Machine
#######################################

:date: 2018-03-04 15:00
:category: Engineering
:slug: copying-pass-secrets-to-another-machine 
:author: John Nduli
:status: draft


I had bought a laptop but I couldn't access my previous one, so I had to
figure out how to get my secrets back. I had two problems to fix:

- I had started storing new passwords using a new gpg key, so how would
  this work when I got my old passwords?
- How would I be able get my old gpg keys into this new laptop?

To get my old gpg keys, my home directory was compressed using borg and
sent to me using:

.. code-block:: bash

    borg init /path/to/folder
    borg create --progess /path/to/backup::susa /home/username


Once I got this file, I just ran:

.. code-block:: bash

    borg mount backup::susa-initial /home/username/borg_mount

This however, mounted the folder as read only, so I couldn't do much
about my gpg keys. Here are some of the errors I got because of this.

.. code-block:: bash

    gpg --homedir $(pwd) --list-keys                                                                                   
    gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881984170.archlinux.39288': Read-only file system
    gpg: keyblock resource '/home/username/borg_mount/home/username/.password-store/pubring.kbx': Read-only file system
    gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881981700.archlinux.39288': Read-only file system
    gpg: Fatal: can't create lock for '/home/username/borg_mount/home/username/.password-store/trustdb.gpg'


I copied over the gpg key into a folder:

.. code-block:: bash

    cp -r borg_mount/home/username/.gnupg/* gpg_tests/  
    cd gpg_tests
    gpg --homedir $(pwd) --list-keys # this now works                                                                                 

And exported my keys with:

.. code-block:: bash

    gpg --homedir $(pwd) --output personal_gpg.gpg --armor --export ID_FOR_KEY
    gpg --homedir $(pwd) --output personal_sec.gpg --armor --export-secret-keys ID_FOR_KEY

Then imported them with my new laptop with:

.. code-block:: bash

    gpg --import personal_gpg.gpg 
    gpg --allow-secret-key-import --import personal_sec.gpg 

Pass stores the gpg_id in its root folder, so I just copied over the
previous pass store into a subdirectory in my new password store.

.. code-block:: bash

    cp previous_passtore ~/.password_store/oldpasswords


Now running pass shows all my passwords, both on from my old laptop and
new laptop.
