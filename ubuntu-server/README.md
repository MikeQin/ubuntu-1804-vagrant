# Ubuntu Server 20.04 LTS

Link: https://app.vagrantup.com/peru/boxes/ubuntu-20.04-server-amd64

## VM Includes

- Docker
- Docker Compose

## Vagrant Commands

```bash
# vagrant init peru/ubuntu-20.04-server-amd64 \
#   --box-version 20200207.01

# To start VM
vagrant up

# When error occurs:
# Then go to file: ~/.vagrant.d\boxes\peru-VAGRANTSLASH-ubuntu-20.04-server-amd64\20200207.01\virtualbox
# Remove line 31: 
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