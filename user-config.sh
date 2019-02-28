#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive

echo "~ User-Config ~"

# User profile
cat <<EOF >> $HOME/.profile
# set path
export PATH=$PATH:.
EOF
source $HOME/.profile

# Add more user config below
# ...
