Source : https://wiki.archlinux.org/index.php/Swap
sudo fallocate -l 10G /swapfiles
sudo chmod 600 /swapfile
sudo mkswap /swapfile
swapon /swapfile


To remove swap:

swapoff -a
rm -f /swapfile
