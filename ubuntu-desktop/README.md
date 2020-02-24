# Ubuntu Desktop 18.04.3

Link: https://app.vagrantup.com/peru/boxes/ubuntu-18.04-desktop-amd64

## VM Includes

- Basic Linux Packages
- Docker
- Docker Compose
- Node & NPM
- Open JDK 8
- Jenkins

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

# To stop VM 
vagrant halt

# SSH
vagrant ssh

# VM Credential
user: vagrant
password: vagrant
```
