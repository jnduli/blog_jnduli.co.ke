
Ansible
#######

:date: 2018-01-06 18:00
:tags: computer, programming, servers
:category: Computer
:slug: ansible
:author: John Nduli
:status: published

Ansible is an automation tool that easens work a lot. I just set
it up once and from then on I can forget about configurations and
settings for my projects. It's really great for doing repeatable
tasks like setting up nginx for subdomains, redeploying django
projects, updating the OS, etc.

For example, to set up a script that updates the server:

.. code-block:: yml
   
    ---

    - hosts: my_server
       vars_files:
         - vars.yml
       remote_user: "{{ user }}"
       become: true
       tasks:
           - name: Running update and safe-upgrade
              apt:
                  update_cache=yes
                  upgrade=dist
              register: result
           - debug: var=result.stdout_lines

I store my variables in the vars.yml file. In the example above,
the user variable is found here. The file looks like this:

.. code-block:: yml

   ---

   user: thisuser

The my_server variable is set in /etc/ansible/hosts file and looks
like this:

.. code-block:: ini

    [my_server]
    random_url.co.ke

Since updating the system requires admin priviledges, make sure
the user has those permissions. This is why the script has
remote_user and become in its body. Also ansible will need to run
with these priviledges, so to do so:

.. code-block:: bash

   ansible-playbook --ask-become-pass updates.yml

And just like that the system gets updated. This asks for the
server password for the elevated user.

Let's say I want to update my nginx config files to enable another
subdomain. Ansible should upload my config file to my server and
also restart nginx so that these changes are accepted.

.. code-block:: yml

    ---
    - hosts: my_server
       vars_files:
         - vars.yml

       tasks:
       # copy project nginx set up to server
         - name: set up nginx config on server
            remote_user: "{{ user }}"
            become: true
            template:
              src=config/nginx.j2
              dest=/etc/nginx/sites-enabled/{{ project_name }}
            notify:
              - restart nginx

       handlers:
         - name: restart nginx
            remote_user: "{{ user }}"
            become: true
            service: name=nginx state=restarted

Since ansible supports jinja templating, the nginx config file is
written in this format. Also the variables project_name and user
are found from the vars.yml file. What the above does is copy the
nginx config file to /etc/nginx/sites-enabled/project_name 
restarts nginx.

Here is the template used. You can also use variables defined in
the vars.yml in the template too, which is really helpful.

.. code-block:: j2

    server {
    #listen 443;
        listen 80;
        server_name {{ server_name }};
        charset utf-8;
        client_max_body_size 2M;

        location / {
            # django
            include proxy_params;
            proxy_pass http://unix:{{ sock_file }};
        }

        location /static {
            autoindex on;
            alias {{ static_root }};
        }

        location /media {
            autoindex on;
            alias {{ media_root }};
        }
    }


Some commands can run with ansible-playbook file.yml but others
need elevated permissions. To help me deal with this I usually
have a Makefile in my ansible playbooks directory. For example to
deal with the two configs above, I'd have:

.. code-block:: make

    ANSIBLE_SUDO = ansible-playbook --ask-become-pass

    update:
        $(ANSIBLE_SUDO) updates.yml
       
    nginx:
        #(ANSIBLE_SUDO) nginx_setup.yml


You can find moer about ansible `here <https://www.ansible.com/>`_
