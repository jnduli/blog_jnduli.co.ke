# GUIX OS with GeneNetwork

Setting up Guix OS is easy since their iso provides a graphical guide. Some
quirks though are:

- Wifi didn't work for me and it needs an internet connection to work. USB
tethering worked though.
- I forgot to change the bootloader to use UEFI so I couldn't boot this. To fix
  this:

  1. Use grub to log into the guix os system
      ```
      # ref: https://superuser.com/a/1512531
      set pager=1
      ls
      # find the drive that has guix_os, looking for one that has /etc/config.scm file
      cat (hd0,1)/etc/config.scm
      set root=(hd0,1)
      cat /boot/grub/grub.cfg
      # run the commands in the menuentry manually
      linux /gnu/store/......
      initrd /gnu/store/.....
      # boot the OS
      boot
      ```
  2. Fix the efi problem changing the bootloader configuration in
     `/etc/config.scm` to:
       ```
       # Ref: https://guix.gnu.org/manual/en/html_node/Bootloader-Configuration.html#index-bootloader_002dconfiguration
       (bootloader (bootloader-configuration
          (bootloader grub-efi-bootloader)
          (targets '("/boot/efi"))
          (keyboard-layout keyboard-layout)))
       ```
  3. Reconfigure the OS with `sudo guix system reconfigure --allow-downgrades /etc/config.scm`

With this, I could easily boot into the OS.

## Quality of Life Changes

### Zsh as default shell

Change `/etc/config.scm` to have:

```guile
;; ref: https://lists.gnu.org/archive/html/help-guix/2017-07/msg00024.html
;; added this
(use-package-modules shells)

(users (cons* (user-account
                (name "rookie")
                (comment "rookie")
                (group "users")
                (home-directory "/home/rookie")
                ;; added this line
                (shell #~(string-append #$zsh "/bin/zsh))
                (supplementary-groups '("wheel" "netdev" "audio" "vidoe")))
            %base-user-accounts))
```

and reconfigured the OS with `sudo guix system reconfigure --allow-downgrades /etc/config.scm`

When installing `oh-my-zsh` I also got an error: `ZSH not installed` so I also
had to do an extra `guix install zsh`.

### Non Guix
Ref: https://gitlab.com/nonguix/nonguix

For wifi set up, I had to do add these to `/etc/config.scm`:

```
;; non free linux module
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
```

The README is really clear, but a problem I had was setting up substitutes
(since I'm unfamiliar with Guile). 

```
;; what ended up in my services section
  (services
   (append (list (service xfce-desktop-service-type)

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service cups-service-type)
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))

           ;; This is the default list of services we
           ;; are appending to.
           ;; %desktop-services)
                (modify-services %desktop-services
                     (guix-service-type config => (guix-configuration
                       (inherit config)
                       (substitute-urls
                        (append (list "https://substitutes.nonguix.org")
                          %default-substitute-urls))
                       (authorized-keys
                        (append (list (plain-file "non-guix.pub"
                                                ;; output from https://substitutes.nonguix.org/signing-key.pub
                                                ;; merged into one line
                                                  "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"
                                                  ))

                          %default-authorized-guix-keys))))))
   )

```


Then reconfigured the system using: `sudo guix system reconfigure --allow-downgrades /etc/config.scm`


### Weird Bug

I couldn't get `tmux` to start, getting `tmux: invalid LC_ALL, LC_CTYPE or LANG`
and running `locale -a` failed too. The root cause seemed to be that my
applications had been built on a different version of `glibc` and running `guix
update` fixed this.
