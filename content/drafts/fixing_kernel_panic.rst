book into virtual environment

and then do:
mount /dev/sdaY /mnt
arch-chroot /mnt /bin/bash

mkinitcpio -p linux
