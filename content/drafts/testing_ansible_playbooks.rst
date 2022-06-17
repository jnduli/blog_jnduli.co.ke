#########################
Testinq ansible playbooks
#########################

:date: 2022-01-15
:category: Computer
:author: John Nduli
:status: draft

Plan:

- go through:
  https://www.ansible.com/blog/five-questions-testing-ansible-playbooks-roles
  and put down notes
- go through:
  https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html
  and put down notes
- https://opensource.com/article/20/1/ansible-playbooks-lessons
- https://molecule.readthedocs.io/en/stable/




TODOS:
- test out all the scripts in the examples
- research standard ways to test things in ansible
- look for resources explaining docker limitations
- modify examples to use ip addresses instead of localhost


I was making some ansible scripts and I wanted to test them out locally before
deploying them to my main server. I figured docker would help me out, especially
for the platform specific tasks, like installing packages using an OS's package
manager. This was possible to some extent within docker, so I created the script
below:

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



and ran this with:

.. code-block:: bash

    # TODO: there should be a way to make use the docker ip address here??
    # note for live syncing we need to mount directories, not files
    docker container run --interactive --tty  --volume $(pwd):/app --rm  ubuntu:20.04 /bin/bash
    apt update && apt install ansible
    ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml


I got stuck when I wanted to launch systemctl services. (TODO: add link to
explanation of this). To test this out, I had to use a Virtual Machine, which
would emulate a whole system. I set up vagrant and tried things out.

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


got me into the box, and I could run an ansible playbook with:

.. code-block:: bash

   sudo apt update && sudo apt install ansible
   ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml
