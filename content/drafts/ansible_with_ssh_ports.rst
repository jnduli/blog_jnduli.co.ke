####################
Ansible and SSH Port
####################

It is advisable to disable the default ssh port on your server for
better security and set it to some random number. This is because bots
and people will try to randomly log into your server. Another useful tip
is to disable root login as this is the most common attempt i.e. log in
using user root and default port.

However, after diabling the ssh port, ansible doesn't work as required
and one needs to set it up to use the new ssh port.

The preferred method I got is by changing the variable in the terminal,
for example:

.. code-block:: bash

    ansible-playbook -i 'example.com:1234' -u 'guest' playbook.yml

This is what I've tested out on my server and it works.

Other alternatives include:

1. Editting every role to include the port required

   .. code-block:: yaml

        - name: Example for port change
          set_fact:
            ansible_port: 1234
   
2. Different command syntax:

 .. code-block:: lua
    
    ansible-playbook playbook.yml -e ansible_ssh_port=1234

3. Using ansibles inventory hosts and setting the port explicitly. Other
   formats for the inventory can be found in the `ansible docs
   <https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#hosts-and-groups>`_
   .. code-block:: bash
   
        [webservers]
        example.com:1234
   
