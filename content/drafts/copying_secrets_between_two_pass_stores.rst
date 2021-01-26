#######################################
Copying Pass Secrets to Another Machine
#######################################

:date: 2018-03-04 15:00
:category: Engineering
:slug: copying-pass-secrets-to-another-machine 
:author: John Nduli
:status: draft



GPG keys import:
- change home dir
- list all keys in this dir
- export keys
- import keys

Couldn't access my laptop, so a borg file store of my home directory was
sent to me.

borg init /path/to/folder
borg create --progess /path/to/backup::susa /home/username

On the other machine, I ran:

borg mount backup::susa-initial /home/username/borg_mount

But this is mounted as read only, so I couldn't do much about this. I
copied over the gpg keys by doing, so trying to copy these fails:

# Fails because borg mounts this as read only
gpg --homedir $(pwd) --list-keys                                                                                   
gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881984170.archlinux.39288': Read-only file system
gpg: keyblock resource '/home/username/borg_mount/home/username/.password-store/pubring.kbx': Read-only file system
gpg: failed to create temporary file '/home/username/borg_mount/home/username/.password-store/.#lk0x000055b881981700.archlinux.39288': Read-only file system
gpg: Fatal: can't create lock for '/home/username/borg_mount/home/username/.password-store/trustdb.gpg'


I copied over the gpg keys with:

cp -r borg_mount/home/username/.gnupg/* gpg_tests/  
cd gpg_tests
gpg --homedir $(pwd) --list-keys                                                                                   
# That now works

And exported my keys with:

gpg --homedir $(pwd) --output personal_gpg.gpg --armor --export ID_FOR_KEY
gpg --homedir $(pwd) --output personal_sec.gpg --armor --export-secret-key ID_FOR_KEY


Then imported them with:

gpg --import personal_gpg.gpg 
gpg --allow-secret-key-import --import personal_sec.gpg 


Pass stores the gpg_id in its root folder, so this helps because I could
just copy out the passfolder and it would work sincee I'd imported the
original keys.

cp previous_passstore ~/.pass_store/oldpasswords


now pass list should have a section with oldpasswords.
