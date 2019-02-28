# Ubuntu Desktop 18.04 LTS Using Vagrant for VirtualBox
Vagrantfile to Build a Ubuntu Desktop 18.04 LTS for VirtualBox.

Box: ```peru/ubuntu-18.04-desktop-amd64```

## VM Includes
- Basic Linux Packages:\
    vim \
    apt-transport-https \
    ca-certificates \
    curl \
    tree \
    git \
    wget \
    leafpad \
    gnupg-agent \
    software-properties-common
- Docker
- Docker Compose
- Node & NPM
- Open JDK 8
- Jenkins

## Vagrant Commands
### To start VM

```vagrant up```

### To stop VM 
```vagrant halt```

### SSH
```vagrant ssh```

## VM Credential
```
user: vagrant\
password: vagrant
```
