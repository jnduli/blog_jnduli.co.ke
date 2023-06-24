#########################
Testinq ansible playbooks
#########################

:date: 2022-01-15
:category: Computer
:author: John Nduli
:status: draft



Plan:

- DONE: https://www.ansible.com/blog/five-questions-testing-ansible-playbooks-roles
- DONE: https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html
- https://opensource.com/article/20/1/ansible-playbooks-lessons
- https://molecule.readthedocs.io/en/stable/
- https://github.com/chrismeyersfsu/provision_docker and https://www.ansible.com/blog/testing-ansible-roles-with-docker


Draft
=====


Docker Attempts
---------------
I wanted to test some ansible scripts locally before deploying them and tried
out docker for this. This worked out great so long as I didn't need systemd.

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

and ran it with:

.. code-block:: bash

    # TODO: there should be a way to make use the docker ip address here??
    # note for live syncing we need to mount directories, not files
    docker container run --interactive --tty  --volume $(pwd):/app --rm  ubuntu:22.04 /bin/bash
    export DEBIAN_FRONTEND=noninteractive
    apt update && apt install ansible
    ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml

A better way of running the above it to use the `community.docker.docker`
connection plug like:

.. code-block:: bash

    docker container run --interactive --tty --volume $(pwd)/rough_work:/app --name ansible_container --rm python:3.10 /bin/bash
    # note we have to disable become: true from the ansible.yml file for this to
    # work. TODO: figure out how to handle this gracefully
    # RUNNING apt-get update && apt-get install sudo seems to fix this
    ansible-playbook -i 'ansible_container,' -c docker test_ansible.yml
    code



Another alternative is to create an image that has ssh access and use this to
run things.


https://zauner.nllk.net/post/0038-running-systemd-inside-a-docker-container/
https://stackoverflow.com/questions/24738264/how-to-test-ansible-playbook-using-docker

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


Research
========

https://www.ansible.com/blog/five-questions-testing-ansible-playbooks-roles

Testing Ansible:

- unit testing: similar to SQL queries, you don't do it. Unit tests belong to
  the python module level.
- functional tests: require a large amount of system state to set up mocking and
  it isn't realistic
- integration testing: most useful e.g. you set up a LAMP stack and issue an
  http request.

Start testing any time. You can test by setting up a clean host and running the
play against this.

https://github.com/chrismeyersfsu/provision_docker


Testing Strategies
==================

https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html

Ansible is push-based, so its really easy to run the steps against localhost or
test servers.

Right Level of Testing:
Ansible resources are models of desired state, so don't test that services are
started or packages are installed, since ansible will ensure that these are
declaratively true.

e.g.

.. code-block:: lua
    
    tasks:
        - ansible.builtin.service:
            name: foo
            state: started
            enabled: true

Ansible will yell appropriately if this isn't started. Note: this is different
from whether the service is functional correct.


Check Mode As A Drift Test:
pass in `--check` to ansible which reports in ansible thinks there's going to be
a change in the system.

Modules That are useful for testing:
Some modules are good for testing, for example:

.. code-block:: ansible

    # ensures a port is open
    tasks:
        - ansible.builtins.wait_for:
          host: "{{ inventory_hostname }}"
          port: 22
        deleteage_to: localhost

    # make sure a web service returns
    tasks:
        - action : uri url=https://www.example.com return_content=yes
          register: webpage

        - fail:
            msg: "Service is not happy"
          when: "'AWESOME' not in webpage.content"

    # push a script to host, and ansible will automatically fail if the script
    has a non zero return code
    tasks:
        - ansible.builtin.script: test_script1

    # assert module can verify certain truths
    tasks:
        - ansible.builtin.shell: /usr/bin/some-command --parameter value
          register: cmd_result
        - ansible.builtin.assert:
            that:
                - "'not_ready' not in cmd_result.stderr"
                - "'gizmo enabled' in cmd_result.stdout"


    # use the stat module to test existence of files not declaratively set by ansible configuration
    - tasks:
        - ansible.builtin.state:
            path: /path/to/sth
          register: p

        - ansible.builtin.assert:
            that:
                - p.stat.exists and p.stat.isdir


Testing Lifecycle:

.. code-block:: yml

    ---

    - hosts: webservers
      serial: 5

      pre_tasks:

        - name: take out of load balancer pool
          ansible.builtin.command: /usr/bin/take_out_of_pool {{ inventory_hostname }}
          delegate_to: 127.0.0.1

      roles:

         - common
         - webserver

      tasks:
         - ansible.builtin.script: /srv/qa_team/app_testing_script.sh --server {{ inventory_hostname }}
           delegate_to: testing_server

      post_tasks:

        - name: add back to load balancer pool
          ansible.builtin.command: /usr/bin/add_back_to_pool {{ inventory_hostname }}
          delegate_to: 127.0.0.1


A script runs from the test machine before bringing back the into the pool.

Open Source Article
-------------------
https://opensource.com/article/20/1/ansible-playbooks-lessons =

Stay organized:
store playbooks in a git repository.
run playbooks from a build server.
have a README with documentation on the playbook's purpose, links to relevant
resources, instructions for local testing and development.
have small, readable task files and extract related sets of tasks into ansible
roles. If a playbook reaches around 100 lines of yaml, split it up and use
`include_tasks`.

Test early and often:

