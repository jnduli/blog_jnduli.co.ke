In the grub rescue menu do:

ls

It will show a list of drives like
(hd0) (hd0,gpt2) (hd0,gpt4)

To get partition with boot in it, do this:

ls (hd0,gpt2)/
ls (hdo,gpt3)/

The one with a files that has boot/ is the one with the linux
partion in it. Assuming its (hd0,gpt3), then do:

sudo root=(hd0,gpt3)
set prefix=(hd0,gpt3)/boot/grub
insmode normal
normal

Then to fix it permanently:

I then did this:

mount /dev/sda1 /boot/efi
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
sudo pacman -S intel-ucode #enabling microcode updates
sudo grub-mkconfig -o /boot/grub/grub.cfg

