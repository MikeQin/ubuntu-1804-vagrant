#!/bin/bash -eux
export DEBIAN_FRONTEND=noninteractive

echo "~ User-Config ~"

# User profile
cat <<EOF >> $HOME/.profile
# set path
export PATH=$PATH:.
EOF
source $HOME/.profile

# Get jenkins server
#wget -q http://mirrors.jenkins.io/war-stable/latest/jenkins.war -O $HOME/jenkins.war
#chmod 755 $HOME/jenkins.war

# Create startup file
#echo 'java -jar jenkins.war --httpPort=8081' > $HOME/jenkins-server.sh
#chmod 755 $HOME/jenkins-server.sh

# Change owner for .dbus dir
sudo chown -R $USER:$USER $HOME/.dbus