I installed stack_static by downloading the binary and putting it into
`.local/bin` but every time I compiled a program I'd get a warning on missing
binary.

TODO: add exact binary warning

The problem seemed to be that guix was somehow messing up with the linker and
the fix for me was to run the stack build in a clean bash environment. I did
this by:

```
env -i /bin/bash --login --noprofile --norc  
export PATH=$PATH:~/.local/bin
stack build
```

And all my problems were fixed. The binary would work even in the polluted
environment.

TODO: create a script to handle this
