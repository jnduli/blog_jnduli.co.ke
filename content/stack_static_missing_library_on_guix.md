Title: Stack Static Missing Library With Guix
Date: 2023-02-25
Category: Computer
Slug: stack_static_missing_library_with_guix
Author: John Nduli
Status: published

I installed stack_static by downloading the binary [from
github](https://github.com/commercialhaskell/stack/releases) and moving it to
`.local/bin`. I was able to compile haskell programs, but running them failed
with the error:

```
$ stack run
/home/rookie/projects/random/helloworld/.stack-work/install/x86_64-linux-tinfo6/48795ad824c5ab2c527b42cc08a43bf5cd587c042c536072710c2302b997bb41/9.2.5/bin/helloworld-exe: error while loading shared libraries: libgmp.so.10: cannot open shared object file: No such file or directory
```

`ldd` showed that the library was missing:

```
$ ldd .stack-work/install/x86_64-linux-tinfo6/48795ad824c5ab2c527b42cc08a43bf5cd587c042c536072710c2302b997bb41/9.2.5/bin/helloworld-exe
        linux-vdso.so.1 (0x00007ffd0958e000)
        libgmp.so.10 => not found
        libc.so.6 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libc.so.6 (0x00007f5b9d530000)
        libm.so.6 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libm.so.6 (0x00007f5b9d3ef000)
        librt.so.1 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/librt.so.1 (0x00007f5b9d3e5000)
        libdl.so.2 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libdl.so.2 (0x00007f5b9d3e0000)
        libpthread.so.0 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libpthread.so.0 (0x00007f5b9d3be000)
        libgcc_s.so.1 => /gnu/store/4zvswpr2h3b7dvqpvjcdam8vfhyjrmgl-gcc-12.2.0-lib/lib/libgcc_s.so.1 (0x00007f5b9d39d000)
        /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/ld-linux-x86-64.so.2 => /gnu/store/ayc9r7162rphy4zjw8ch01pmyh214h82-glibc-2.33/lib/ld-linux-x86-64.so.2 (0x00007f5b9d6f4000)
```

I noticed the search path for most libraries were guix related, so I ran the OS
provided ldd and it found the `libgmp.so.10` library.

```
$ /usr/bin/ldd .stack-work/install/x86_64-linux-tinfo6/48795ad824c5ab2c527b42cc08a43bf5cd587c042c536072710c2302b997bb41/9.2.5/bin/helloworld-exe
        linux-vdso.so.1 (0x00007ffc41cc0000)
        libgmp.so.10 => /lib/x86_64-linux-gnu/libgmp.so.10 (0x00007f4148ad2000)
        libc.so.6 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libc.so.6 (0x00007f4148910000)
        libm.so.6 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libm.so.6 (0x00007f41487cf000)
        librt.so.1 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/librt.so.1 (0x00007f41487c5000)
        libdl.so.2 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libdl.so.2 (0x00007f41487c0000)
        libpthread.so.0 => /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/libpthread.so.0 (0x00007f414879e000)
        libgcc_s.so.1 => /gnu/store/4zvswpr2h3b7dvqpvjcdam8vfhyjrmgl-gcc-12.2.0-lib/lib/libgcc_s.so.1 (0x00007f414877d000)
        /gnu/store/5h2w4qi9hk1qzzgi1w83220ydslinr4s-glibc-2.33/lib/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 (0x00007f4148b68000)
```

I didn't know how to add the library to guix (`guix install gmp` didn't fix
this). The solution was to compile the program using native OS level utilities.

```
# opens bash without guix loaded utilities
env -i /bin/bash --login --noprofile --norc  
export PATH=$PATH:~/.local/bin
stack build
```

The binary worked without an errors.
