# Proxy Configuration Plugin for Vagrant

## Quick start

http://tmatilai.github.io/vagrant-proxyconf/

Install the plugin:
```
vagrant plugin install vagrant-proxyconf
```

To configure all possible software on all Vagrant VMs, add the following to $HOME/.vagrant.d/Vagrantfile (or to a project specific Vagrantfile):

```
Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://192.168.0.2:3128/"
    config.proxy.https    = "http://192.168.0.2:3128/"
    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  end
  # ... other stuff
end
```