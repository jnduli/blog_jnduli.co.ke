While working with ansible, we can test the scripts locally, but
sometimes its some platform specific things I want to test out, for
example installation of packages using a custom os's thing. I think
there are better ways, but the first though I got was to try and use
docker, which worked out really great for a start.

So let's say I want to test out script installations on ubuntu, how
would I do that?

TODO: test these bits

.. code-block:: yml

    ---
    - hosts: all
      tasks:
        - name: update apt pkg cache and install packages
          become: true
          apt:
            update_cache: yes
            pkg:
              - git
              - nvim

and to test this out we can run:

.. code-block:: bash

    # docker container run --interactive --tty  --volume /home/rookie/projects/comic_server:/app/:rw --rm  ansible_comic_server /bin/bash
    docker container run --interactive --tty  --volume test_ansible.yml:/test_ansible.yml --rm  ubuntu:20.04 /bin/bash
    apt install ansible
    ansible-playbook -f /test_ansible.yml -i 'localhost,' --connection=local

and install ansible in the container and run the script. I think there's
a way to run this without this.

However, since docker is a stripped down version, there are things that
are difficult to test. One that I encountered was systemctl stuff. To
test this, I used a VM and ended up learning a bit of vault in the
process.








The problem I encountered was that since the image is a stripped down
version with limited functionality, I couldn't test out things that
start services or use system ctl or use docker.

The other option I got was to use vagrant.

# install virtualbox


╰─$ yay -S libvirt qemu vagrant
╰─$ systemctl start libvirtd virtlogd
vagrant plugin install vagrant-libvirt
vagrant up --provider=libvirt

╰─$ sudo usermod --append --groups libvirt rookie                                                                              1 ↵

╰─$ yay -S iptables-nft dnsmasq bridge-utils
