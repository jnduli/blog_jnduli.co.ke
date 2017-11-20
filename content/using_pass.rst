#########################################
Using Pass - A Password Manager/Generator
#########################################


:date: 2017-08-09 15:00
:tags: pass, linux
:category: Computer
:slug: password-manager-pass
:author: John Nduli
:status: draft

First install pass:

    sudo pacman -S pass

Then:

    pass init email

To insert,
    pass insert /email/email@dns.com

If you get 
gpg: yohanaizraeli@gmail.com: skipped: No public key                                          
gpg: [stdin]: encryption failed: No public key                                                
Password encryption aborted. 

THen you have to first generate the gpg keys:

   gpg --full-gen-key 

This will take you through the process step by step.

TO generate a password:
    pass generate name/of/service 10

will generate a password 10 characrers long

    pass -n generate name/of/service 10

will generate password without special symbols

TO edit or overwirte password
    password edit name/of/service or pass inserte

pass name/of/service : displays the password
pass -c name/of/service : coopies the password to xclip

pass rm name/of/sercie :removes password
pass rm -r name : removes full directory

pass git init : sets up git in pass folder
gpg: yohanaizraeli@gmail.com: skipped: No public key                                          
gpg: [stdin]: encryption failed: No public key                                                
