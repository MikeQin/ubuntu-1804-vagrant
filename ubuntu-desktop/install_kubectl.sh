#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

echo "~ Install Kubectl ~"

# Install
apt-get update && apt-get upgrade -yq
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubectl

# Test to ensure the version you installed is up-to-date
kubectl version --client
#kubectl version --short

echo "~ Kubectl COMPLETE ~"