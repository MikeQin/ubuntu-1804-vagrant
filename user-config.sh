#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive

echo "~ User-Config ~"

# User profile
cat <<EOF >> $HOME/.profile
# set path
export PATH=$PATH:.
EOF
source $HOME/.profile

# Change owner for .dbus dir
sudo chown -R $USER:$USER $HOME/.dbus

# Add more user config below
# ...
