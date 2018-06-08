###########################
Setting and Using Mercurial
###########################

:date: 2018-06-08 09:00
:tags: linux
:category: Computer
:slug: setting-and-using-mercurial
:author: John Nduli
:status: draft

I've always wanted to use mercurial.

Set it up both on the server and my laptop:

    sudo pacman -S mercurial
    sudo apt install mercurial
    
Create a new repo on the server with:
    
    cd /path/to/hg/repo
    hg init trial

On the local machine, I use ssh to clone from the server.

    hg clone ssh://user@example.com:3300/path/to/hg/repo/trial

     hg clone ssh://rookie@jnduli.co.ke/hg/trial

This adds the link as the default remote repo. It can be viewed by
doing:
    hg paths

And we get this:
    default = ssh://rookie@jnduli.co.ke/hg/trial

Basic usage commands:
    hg status
    hg add <file_name>
    hg commit -m "message"
