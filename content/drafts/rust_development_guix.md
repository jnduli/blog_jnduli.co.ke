
Rust development is complicated since:

- I'm forced to modify Mason's downloaded rust-analyzer since it can't find some
  libraries.
- Guix doesn't provide a lot of the tools needed e.g. `cargo watch`, `cargo
  test` and installing them separately with `cargo` results in the first bug.
- I'm limited to the rust compiler provided by guix.


To solve this, we have `guix shell`. Here's the set up I currently use:


```
guix shell --network --container --emulate-fhs \
    --preserve=$ \
    coreutils gcc-toolchain pkg-config glib cairo at-spi2-core pango@1.50 gdk-pixbuf gtk+  glibc-locales \
    zsh git curl neovim stow grep nss-certs sed gzip \
    --preserve='^DISPLAY$' --preserve='^XAUTHORITY$' --expose=$XAUTHORITY \
    --share=$HOME/rusthome=$HOME \
    --share=$HOME/projects/rust_tasks=$HOME/projects/rust_tasks \
    -- zsh
```

Things to fix:

- ssh access?
- how to mount actual code folder for use?

[Ref](https://www.futurile.net/2023/04/29/guix-shell-virtual-environments-containers/)


# Updateing Neovim

```
guix build neovim --with-source=neovim@0.10.1=./neovim --with-latest=tree-sitter
guix package --install /output/path/from/previous/command
```
