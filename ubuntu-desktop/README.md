# Ubuntu Desktop 20.04 LTS

Link: https://app.vagrantup.com/peru/boxes/ubuntu-18.04-desktop-amd64

## VM Includes

- Basic Linux Packages
- Docker
- Docker Compose

## Vagrant Commands

```bash
# vagrant init peru/ubuntu-18.04-desktop-amd64 \
#   --box-version 20200207.01

# To start VM
vagrant up

# When error occurs:
# Then go to file: ~/.vagrant.d\boxes\peru-VAGRANTSLASH-ubuntu-18.04-desktop-amd64\20200207.01\virtualbox
# Remove line: 
virtualbox.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]

# To start VM
vagrant up

# Force provision if the first time failed
vagrant provision

# To stop VM 
vagrant halt

# SSH
vagrant ssh

# VM Credential
user: vagrant
password: vagrant
```
