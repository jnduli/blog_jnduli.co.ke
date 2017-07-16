###
SSH
###

TO generate a key:
    
    ssh-keygen -t rsa

Follow the prompts until the end.
To set up the key in a server, do:

    ssh-copy-id user@ipaddress

TO disable password login do:

    sudo vim /etc/ssh/sshd_config

TO disable password login:
PasswordAuthentication no

THen:

    reload ssh


