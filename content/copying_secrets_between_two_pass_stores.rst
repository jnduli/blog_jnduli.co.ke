#######################################
Copying Pass Secrets to Another Machine
#######################################

:date: 2021-03-27
:category: Engineering
:slug: copying-pass-secrets-to-another-machine 
:author: John Nduli
:status: published


I had a new laptop but couldn't access my previous one, so I had to
figure out how to get my `pass <https://www.passwordstore.org/>`_
secrets. I had these problems:

- How would I get my old password store?
- How would I be able get my old gpg keys into this new laptop?
- I had started storing new passwords using a new gpg key, so how would
  this work the old password store (generated with a different key)?

Getting the old secrets
-----------------------
My home directory was compressed using `borg
<https://borgbackup.readthedocs.io/en/stable/>`_ and sent to me using:

.. code-block:: bash

    borg init /path/to/folder
    borg create --progess /path/to/backup::susa /home/username

And on my laptop I ran:

.. code-block:: bash

    borg mount backup::susa-initial /home/username/borg_mount

This folder is mounted as read only, limiting what I could do in it.
Here are some of the errors I got because of this.

.. code-block:: bash

    gpg --homedir $(pwd) --list-keys                                                                                   
    gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881984170.archlinux.39288': Read-only file system
    gpg: keyblock resource '/home/username/borg_mount/home/username/.password-store/pubring.kbx': Read-only file system
    gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881981700.archlinux.39288': Read-only file system
    gpg: Fatal: can't create lock for '/home/username/borg_mount/home/username/.password-store/trustdb.gpg'

I copied over the gpg key into a folder outside the mounted borg folder:

.. code-block:: bash

    cp -r borg_mount/home/username/.gnupg/* gpg_tests/  
    cd gpg_tests
    gpg --homedir $(pwd) --list-keys # this now works                                                                                 

And exported my keys with:

.. code-block:: bash

    gpg --homedir $(pwd) --output personal_gpg.gpg --armor --export ID_FOR_KEY
    gpg --homedir $(pwd) --output personal_sec.gpg --armor --export-secret-keys ID_FOR_KEY

I imported them them with:

.. code-block:: bash

    gpg --import personal_gpg.gpg 
    gpg --allow-secret-key-import --import personal_sec.gpg 

Working with both password stores
---------------------------------
Pass stores the `gpg_id` in its root folder, so I just copied over the
previous pass store into a subdirectory in my new password store.

.. code-block:: bash

    cp home/username/.password_store ~/.password_store/oldpasswords

Now running pass shows all my passwords, both on from my old laptop and
new laptop. It's a little inconvenient because I now have an extra node
to go through to access my old passwords but this is an acceptable
compromise.

Another unexplored alternative is to convert all the old passwords to
use the new gpg key. It should be a simple script that just gets the
password from the old gpg key and saves it into the new store.
