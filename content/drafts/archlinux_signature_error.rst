error: zstd: signature from "Andrzej Giniewicz (giniu) <gginiu@gmail.com>" is marginal trust
:: File /var/cache/pacman/pkg/zstd-1.3.2-1-x86_64.pkg.tar.xz is corrupted (invalid or corrupted package (PGP signature)).
Do you want to delete it? [Y/n] Y
error: failed to commit transaction (invalid or corrupted package (PGP signature))
Errors occurred, no packages were upgraded.


To fix this:

sudo pacman -Sy archlinux-keyring manjaro-keyring
sudo pacman-key --populate archlinux manjaro
sudo pacman-key --refresh-keys

Source: https://forum.manjaro.org/t/cant-update-signature-from-andrzej-giniewicz-giniu-gginiu-gmail-com-is-marginal-trust/33259
