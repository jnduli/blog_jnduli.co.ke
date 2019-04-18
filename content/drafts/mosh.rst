####
Mosh
####

:date: 2018-03-04 15:00
:tags: linux
:category: Computer
:slug: mosh
:author: John Nduli
:status: draft

On local machine:

    pacman -S mosh

On server:
    
    sudo apt install mosh
    sudo ufw allow 60000:60020/udp

To link up to server, do:

    mosh username@server_ip
    mosh --ssh="ssh -p 22000" user@example.com

Resource:
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-mosh-on-a-vps

The best thing about mosh is that it is more interactive. This is
because they have predictive echoing.
With mosh, ssh connections are faster because they


