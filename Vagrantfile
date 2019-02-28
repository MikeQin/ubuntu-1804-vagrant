# Add a box to local machine: 
#   vagrant box add peru/ubuntu-18.04-desktop-amd64
#   vagrant box list
#   vagrant box -help
# ---------------------------------
# To start VM:
#   vagrant up
# To stop VM:  
#   vagrant halt
# SSH:
#   vagrant ssh
# ---------------------------------
# user: vagrant
# password: vagrant 

Vagrant.configure("2") do |config|
  config.vm.box = "peru/ubuntu-18.04-desktop-amd64"
  config.vm.box_version = "20190222.03"
  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.name = "ubuntu_18.04_vagrant"
    v.memory = 4096
    v.cpus = 2
  end
  config.vm.provision "shell", path: "bootstrap.sh", args: ["vagrant"]
  config.vm.provision "shell", path: "user-config.sh", privileged: false
end