# GUIX OS with GeneNetwork

Disclaimer: I'm a newbie in guix and genenetwork.

Guix OS involves [downloading the iso](https://guix.gnu.org/download/); setting
it on a flash disk with: `dd if=guix-system-install-1.4.0.x86_64-linux.iso
of=/dev/sdX status=progress`; and using the graphical guide. Some quirks I got
were:

- I needed an internet connection but wifi didn't work out of the box. I used
  USB tethering though.
- I forgot to edit the final configuration to UEFI. To boot, I used grub by:
  ```bash
  # ref: https://superuser.com/a/1512531
  set pager=1
  ls
  # find the drive that has guix_os by searching for /etc/config.scm file
  cat drive_from_ls/etc/config.scm # e.g. cat (hd0,1)/etc/config.scm
  set root=drive_from_ls # e.g. set root=(hd0,1)
  cat /boot/grub/grub.cfg
  # run the commands in the menuentry manually
  linux /gnu/store/......
  initrd /gnu/store/.....
  # boot the OS
  boot
  ```
- I changed my bootloader config in `/etc/config.scm` to fix the efi issue
  ```guile
  ;; Ref: https://guix.gnu.org/manual/en/html_node/Bootloader-Configuration.html#index-bootloader_002dconfiguration
  (bootloader (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (keyboard-layout keyboard-layout)))
  ```
  and rebuild the OS with `sudo guix system reconfigure --allow-downgrades /etc/config.scm`
- I experienced screen flickering in my terminal and fixed it with modify my
  boot parameters:
  ```guile
  ;; ref: https://wiki.archlinux.org/title/Intel_graphics#Screen_flickering
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (kernel-arguments (list "i915.enable_psr=0"))
  ```

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

When installing `oh-my-zsh` I also got an error: `ZSH not installed` so I also
had to do an extra `guix install zsh`.

### Non Guix
[Ref](https://gitlab.com/nonguix/nonguix)

For wifi to work, I modified `/etc/config.scm` to have:

```
;; non free linux module
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
```

The README did most of the heavy lifting, but I couldn't figure out how to add the substitutes.

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

### Locale Bug

I couldn't get `tmux` to start, getting `tmux: invalid LC_ALL, LC_CTYPE or LANG`
and running `locale -a` failed too. The root cause was that my applications were
built on a different version of `glibc` and running `guix update` fixed this.

# GeneNetwork Setup
[Follow the instructions here to set up genenetwork](https://issues.genenetwork.org/topics/guix/guix-profiles)

Small changes:

```bash
# pick the channels file from 
curl https://ci.genenetwork.org/channels.scm > channels.scm
# gn2 setup
guix pull -C channels.scm -p ~/.guix-extra-channels/gn2
GUIX_PROFILE=$HOME/.guix-extra-profiles/gn2
. $GUIX_PROFILE/etc/profile
guix install genenetwork2 -p ~/.guix-extra-channels/gn2
guix install genenetwork3 -p ~/.guix-extra-channels/gn2 # setups an older version

# gn3 setup
guix pull -C channels.scm -p ~/.guix-extra-channels/gn3
GUIX_PROFILE=$HOME/.guix-extra-profiles/gn3
. $GUIX_PROFILE/etc/profile
guix install genenetwork3 -p ~/.guix-extra-channels/gn3
guix install genenetwork2 -p ~/.guix-extra-channels/gn3
guix package -i python-mysqlclient -p ~/.guix-extra-channels/gn3
guix package -i python-pyld -p ~/.guix-extra-channels/gn3
pytest -k unit_tests # succeeds after this
pytest # still fails
FLASK_DEBUG=1 FLASK_APP="main.py" flask run --port=8080 # works

# gn-auth set up is a bit different from the above
# the README is clear in this case
# just make sure you have genenetwork2 and genetwork3 installed in the profile
```

mysql set up
```
sudo mysqld_safe --user root --datadir=/home/rookie/gn_data/mariadb/db_test
```
