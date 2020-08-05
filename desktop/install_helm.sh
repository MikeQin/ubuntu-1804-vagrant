#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

echo "~ Install Helm ~"

# Install
curl https://helm.baltorepo.com/organization/signing.asc | apt-key add -
# apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install helm

echo "~ Helm COMPLETE ~"