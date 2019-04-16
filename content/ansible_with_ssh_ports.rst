####################
Ansible and SSH Port
####################
:date: 2019-04-16 09:00
:tags: programming, server
:category: Computer
:slug: ansible-and-ssh-ports
:author: John Nduli
:status: published

Hackers and bots try to log into servers all the time. They do this by
trying random ssh logins into your server. A deterrent to this is to
disable the default ssh port and set it to something else. Also, disable
root login as this is the most common user attempt I've seen on my
server.

To disable the port globally, just edit the `/etc/ssh/sshd_config` file
to have the line shown below (the `1234` should be any number you wish below 65535):

.. code-block:: bash
    
    Port 1234


After disabling port 22, ansible did not work as expected because if
uses this port by default. To fix this, the url used
with my playbooks was changed from the terminal, as shown below.

.. code-block:: bash

    ansible-playbook -i 'example.com:1234' -u 'guest' playbook.yml

Other alternatives I found while researching this include:

1. Editting every role to include the port required

   .. code-block:: yaml

        - name: Example for port change
          set_fact:
            ansible_port: 1234
   
2. Setting the port directly with `ansible_ssh_port`:

 .. code-block:: bash
    
    ansible-playbook playbook.yml -e ansible_ssh_port=1234

3. Using ansibles inventory hosts and setting the port explicitly. Other
   inventory formats can be found in the `ansible docs
   <https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#hosts-and-groups>`_

   .. code-block:: bash
   
        [webservers]
        example.com:1234
