While working with ansible, we can test the scripts locally, but
sometimes its some platform specific things I want to test out, for
example installation of packages using a custom os's thing. I think
there are better ways, but the first though I got was to try and use
docker, which worked out really great for a start.

So let's say I want to test out script installations on ubuntu, how
would I do that?

TODO: test these bits

.. code-block:: yml

    # test_ansible.yml
    ---
    - hosts: all
      tasks:
        - name: update apt pkg cache and install packages
          become: true
          apt:
            update_cache: yes
            pkg:
              - git
              - vim

and to test this out we can run:

.. code-block:: bash

    # note for live syncing we need to mount directories, not files
    docker container run --interactive --tty  --volume $(pwd):/app --rm  ubuntu:20.04 /bin/bash
    apt update && apt install ansible
    ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml

and install ansible in the container and run the script. I think there's
a way to run this without this.

However, docker is a minimal version of linux and doesn't have all the
bolts and nuts of a VM. One that I encountered was systemctl stuff. To
test this, I used a VM and ended up learning a bit of vault in the
process.

.. code-block:: bash

    sudo pacman -S virtualbox vagrant

and have the following Vagrantfile:

.. code-block:: ruby

    # Vagrantfile
    VAGRANTFILE_API_VERSION = "2"

    Vagrant.configure("2") do |config|
        config.vm.box = "generic/ubuntu2004"
        # config.vm.box = "bento/ubuntu-20.04"
        config.vm.network "public_network"
        config.vm.synced_folder "./", "/app"
    end

And running:

.. code-block:: bash

    vagrant up
    vagrant ssh


gets me into the box. We can then run the ansible play book with:

.. code-block:: bash

   sudo apt update && sudo apt install ansible
   ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml
