Plan:

- Set up VM using light weight ubuntu
- Set up guix
- Set up python and attempt to use this
- Research setting up i3 using guix
- Research how to manage dotfiles using guix



Virtual Box Setup:
- New, add name (don't use Expert Mode)
- memory size: if 8GB of Ram, do 3Gg, if you have 15GB, set 4 or 5.
- hard disk set up: create a virtual disk, create, use VDI
  dynamically allocated is slower, so prefer fixed size.
  For size, do like 10GB.
- Modify settings i.e. right click image and click on settings.
    - general -> advanced: enable shared clipboard in bidirectinal way.
    - system -> processor: change to half no of vcpus - 1
            extended features: enable PAE/NX and nexted VT/AMD if available
    - acceleration: leave things checked
    - dispay -> screen: max out video memory and enable 3d acceleration
    - set up shared folders: helps copy folders between host and VM and
      automount

