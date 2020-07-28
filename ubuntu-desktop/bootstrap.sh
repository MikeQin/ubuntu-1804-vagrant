#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

echo "~ Bootstrap ~"

# Update and upgrade first
apt-get update && apt-get upgrade -yq

# Prepare basic packages
apt-get install -yq \
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

# Add apt-key and apt-repository for docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install docker
apt-get install -yq docker-ce docker-ce-cli containerd.io

# Post install docker
usermod -aG docker $1
systemctl enable docker
# After adding vagrant user to docker group, the system needs to reboot
# $ systemctl reboot -i

## Set up Docker Compose
curl -sSL "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" \
 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install NodeJS
# To install the LTS release, use this PPA 'setup_8.x'.
# 'sudo bash -' runs root login shell, and it's optional '-' 
# here since user is root already
#curl -sSL https://deb.nodesource.com/setup_8.x | bash -
#apt-get install -yq nodejs

# Install openjdk8
#apt-get install -yq openjdk-8-jdk
# Set JAVA_HOME
#cat <<EOF >> /etc/environment
#JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#EOF
#source /etc/environment

# Install jenkins service
# 'curl -fsSL' is the same as 'wget -q -O -'
#wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
# Append to sources.list
#echo 'deb https://pkg.jenkins.io/debian-stable binary/' >> /etc/apt/sources.list
#apt-get update
#apt-get install -yq jenkins
#systemctl enable jenkins

# Final update and clean-up
apt-get update
apt-get upgrade -yq
apt autoremove --purge -yq
