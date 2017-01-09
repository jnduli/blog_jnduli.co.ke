Title: Digital Ocean Server Setup
Date: 2016-12-13 07:20
Category: Computer
Tags: computer, servers
Slug: digital-ocean-server-setup
status:draft
Author: John Nduli
Summary: step by step guide on how I setup digital ocean droplet

There is an easy html page set up tool that helps set up the
account. In my case, I did not choose to use ipv6 or to use ssh
key on login. However most of the options can be changed later on
as I learnt.

The first thing I did was add public key authentification for my
root user. I did that by:

    ::console
    ssh root@server-ip
    answer yes to question
    input password

This just confirms that I can log into the system. I then exit ssh
and do the following:

    ::console
    ssh-keygen
    ssh-copy-id root@server-ip

After this process I can now login to my server without the need
for my password.

I then add another user to the system who will have root
priviledges:

    ::console
    ssh root@server-ip
    adduser username
    usermod -aG sudo username

Add public key authentification:
    
    ::console
    ssh-keygen
    ssh-copy-id username@server_ip

Disable passwd, however I did not do this step

    ::console
    sudo vi /etc/ssh/sshd_config
    set
        PasswordAuthentification no
    sudo system reload sshd

set up firewall:

    ::console
    sudo ufw app list 
    sudo ufw allow OpenSSH
    sudo ufw status ;should see OpenSSH

I then installed nginx as my server of choice:

    ::console
    sudo apt update
    sudo apt install nginx

And then added it to my firewall:

    ::console
    sudo ufw app list
    //only enable HTTP because we onoly have port 80 enabled
    //when port 443 set, we can enable HTTPS / Nginx Full
    sudo ufw enable 'Nginx HTTP'
    sudo ufw status
    systemctl status nginx

This is a neat trick I got about how to get your ip address from
the terminal

    ::console
    ip addr show eth0 | grep inet | awk '{ print $2; }' | sed
    's/\/.*$//'

    or

    ::console
    sudo apt-get install curl
    curl -4 icanhazip.com

For a database I decided to install mariadb

    ::console
    sudo apt install mariadb-server mariadb-client
    sudo mysql_secure_installation

I then installed php:

    ::console
    sudo apt-get install php-fpm php-mysql

    sudo vim /etc/php/7.0/fpm/php.ini
    set: cgi.fix_pathinfo =0; secure better the system

