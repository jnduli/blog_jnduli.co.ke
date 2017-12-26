#######
Ansible
#######

:date: 2017-12-26 15:00
:tags: computer, programming, servers
:category: Computer
:slug: ansible
:author: John Nduli
:status: draft

Ansible is an automation tool that easens work a lot. It's kind of
a do it once and repeat thereafter scenario, whereby zero effort
or thought is put into the repeat.

I learnt ansible some time back and I've been using it to set up
servers and configuration on the servers. Also for deployment I've
been using it too. It actually helps a lot.

For example, if I want to update my server, this is how I do it:

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
the user variable is found here.

.. code-block:: yml

   ---
   user: thisuser


Since updating the system requires admin priviledges, make sure
the user has those permissions. Also ansible will need to run with
these priviledges, so to do so:

.. code-block:: bash

   ansible-playbook --ask-become-pass updates.yml

And just like that the system gets updated.

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
are found from the vars.yml file.

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

