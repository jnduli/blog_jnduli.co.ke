#########################
ArchLinux Signature Error
#########################


:date: 2017-11-30 20:00
:tags: linux
:category: Computer
:slug: archlinux-pacman-signature-error
:author: John Nduli
:status: published

When updating archlinux using:

.. code-block:: bash

    sudo pacman -Syu

I sometimes get an error message that looks something like this:

.. code-block:: bash

    error: zstd: signature from "Andrzej Giniewicz (giniu) <randomemail@gmail.com>" is marginal trust
    :: File /var/cache/pacman/pkg/zstd-1.3.2-1-x86_64.pkg.tar.xz is corrupted (invalid or corrupted package (PGP signature)).
    Do you want to delete it? [Y/n] Y
    error: failed to commit transaction (invalid or corrupted package (PGP signature))
    Errors occurred, no packages were upgraded.

Pacman uses a collection of PGP keys which check signed packages
and databases. If a key is corrupted or invalid, a package cannot
be installed or updated. In the example presented above, the
package zstd prevented my whole system from getting upgraded.

To fix this, you try to update the keys using the following:

.. code-block:: bash

    sudo pacman -Sy archlinux-keyring
    sudo pacman-key --populate archlinux
    sudo pacman-key --refresh-keys

The source for this fix is from `here:source <https://forum.manjaro.org/t/cant-update-signature-from-andrzej-giniewicz-giniu-gginiu-gmail-com-is-marginal-trust/33259>`_
