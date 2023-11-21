Title: Testinq ansible playbooks
Date: 2022-01-15
Category: Computer
Slug: testing_ansible_playbooks
Author: John Nduli

# Using Docker

I wanted to test my ansible scripts locally and tried docker. Here's the
`Dockerfile` I used:

```Dockerfile
# Ref: https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    ansible python3-apt \
    systemd systemd-sysv \
    && rm -rf /var/lib/apt/lists/* # I think I need to remove this so that check works

RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "usr/sbin/init" ]

```

So using the ansible script below:


```yml
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

        - name: enable and start services
          become: true
          systemd:
              enabled: true
              state: started
              name: '{{ item }}'
          loop:
            - nginx
            - docker

```

and ran it with:

```bash
# build image
docker image build -f ansible_dockerfile -t ansible-docker .
# run the container
docker container run -it --name ansible_container --rm ansible-docker /bin/bash
# ansible check from another terminal
ansible-playbook -i 'ansible_container,' -c docker --vault-id dev@vault-password.sh --check test_ansible.yml
```

<!-- TODO: test the commands below: -->
### Using virtual machines

I got stuck when I wanted to launch systemctl services. (TODO: add link to
explanation of this). To test this out, I had to use a Virtual Machine, which
would emulate a whole system. I set up vagrant and tried things out.

```bash
sudo pacman -S virtualbox vagrant
```

and have the following Vagrantfile:

```ruby
# Vagrantfile
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu2004"
    # config.vm.box = "bento/ubuntu-20.04"
    config.vm.network "public_network"
    config.vm.synced_folder "./", "/app"
end
```

And running:

```bash
vagrant up
vagrant ssh
```


got me into the box, and I could run an ansible playbook with:

```bash
sudo apt update && sudo apt install ansible
ansible-playbook -i 'localhost,' --connection=local /app/test_ansible.yml
```
