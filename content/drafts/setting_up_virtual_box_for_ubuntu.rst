

I was required to use ubuntu and I wasn't sure I'd replicate my current set up
there. I also wanted a reproducible build, so I looked into guix as a package
manager and like it.

I first set up a VM with VirtualBox and installed xubuntu. The set up follows
this video: https://www.youtube.com/watch?v=qL3xc8hwU7c

- Open Virtual Box, select New and add a descriptive name.
- Make sure Expert Mode is disabled, then click Next
- Set memory size to 3GB
- Preallocate hard disk space. Avoid dynamically allocated since it'll be
  slower. Use VDT to create the virtual disk and I used 25GB space.
- After image is created, modify more settings.
    - general -> advanced: enable shared clipboard in bi-directional way.
    - system -> processor: change to total number of vcpus/2 - 1
    - display -> screen: max out video memory and disable 3d acceleration
    - set up shared folders: helps copy folders between host and VM and
      auto-mount
- set up guest additions:
    - install gcc, perl, make: `sudo apt install gcc make perl`
    - go to devices > insert special additions cd/rom, this will restart some
      prompt and after you add your passwords insert kernel modules for you.
- restart kernel



TODO: look for way to do this from the commandline
