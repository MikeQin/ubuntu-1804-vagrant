# Vagrant

To create Ubuntu 20.04:
- [Ubuntu Desktop](ubuntu-desktop/README.md)
- [Ubuntu Server](ubuntu-server/README.md)

## Install Ubuntu

```bash
# To start VM
vagrant up

# When error occurs:
# Then go to file: ~/.vagrant.d\boxes\peru-VAGRANTSLASH-ubuntu-18.04-server-amd64\20200207.01\virtualbox
# Remove line 31: 
virtualbox.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]

# To start VM
vagrant up
```

### Mouse Integration

- After VM created, go to `Settings -> System -> Motherboard -> Pointing Device`:
- Set the value to `USB Tablet`

### Change Network Settings if necessary

- NAT Adapter -> Bridged Adapter
- Bridged Adapter::Advanced => Promiscuous Mode: Allow All

## Static IP Configuration

Ubuntu reference: https://ubuntu.com/server/docs/network-configuration

### Change `hostname` & add entries to `hosts` file
sudo vim /etc/hostname
sudo vim /etc/hosts

```
sudo reboot
```

### Ubuntu Server
To configure your system to use static address assignment, create a netplan configuration in the file /etc/netplan/01-netcfg.yaml. The example below assumes you are configuring your first Ethernet interface identified as eth0. Change the addresses, gateway4, and nameservers values to meet the requirements of your network.

```
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.101/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
```

The configuration can then be applied using the netplan command.
```
sudo netplan apply
```

### Ubuntu Desktop

```
Settings::Network::Wired => Settings
IPv4 => Manual
Addresses
  Address: 192.168.1.120
  Netmask: 255.255.255.0
  Gateway: 192.168.1.1
DNS
  8.8.8.8

"Apply"
```

### OpenWrt Router Configuration

Router Console: http://192.168.1.1

```
Network => Static Routes
- Target: 192.168.1.101, IPv4 Netmask: 255.255.255.0, IPv4 Gateway: 192.168.1.1 Metric: 0, MTU: 1500
- Target: 192.168.1.120, IPv4 Netmask: 255.255.255.0, IPv4 Gateway: 192.168.1.1 Metric: 0, MTU: 1500

"Save & Apply"

Network => Hostnames
- Hostname: master, IP address: 192.168.1.120
- Hostname: node-1, IP address: 192.168.1.101

"Save & Apply"
```