#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive

echo "~ User-Config ~"

# User profile
cat <<EOF >> $HOME/.profile
export PATH=$PATH:.
EOF
source $HOME/.profile

echo "~ Ubuntu Server Provision COMPLETED ~"