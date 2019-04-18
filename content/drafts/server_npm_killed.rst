#####################
Server Npm killed fix
#####################

:date: 2019-03-04


npm install in server was failing with message:
    killed.

.. TODO find memory requirements for npm

To fix this I did:
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf


Source:
https://www.digitalocean.com/community/questions/npm-gets-killed-no-matter-what
