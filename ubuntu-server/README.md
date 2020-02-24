# Ubuntu Server 18.04.4

Link: https://app.vagrantup.com/peru/boxes/ubuntu-18.04-server-amd64

## VM Includes

- Docker
- Docker Compose

## Vagrant Commands

```bash
# vagrant init peru/ubuntu-18.04-server-amd64 \
#   --box-version 20200207.01

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