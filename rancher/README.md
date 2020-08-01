# Rancher for Kubernetes

## Install `docker` first

See instructions for installing `docker`.

## Disable `worker-node` firewall permanently on CentOS

Firewall on CentOS is enabled by default. We need to disable it to make the Kube cluster work. See intructions.

```bash
sudo systemctl status firewalld
```

## Optionally, Install `kubectl` using package manager

- Install Guide, https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux

#### CentOS

```bash
# As a root user first
sudo su

# Set up repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Install
yum install -y kubectl

# Exit root
exit

# Test to ensure the version you installed is up-to-date
kubectl version --client
kubectl version --short
```

#### Ubuntu

```bash
# As a root user first
sudo su

# Install
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Exit root
exit

# Test to ensure the version you installed is up-to-date
kubectl version --client
kubectl version --short
```

## Before Installing Rancher

To install and run Rancher, execute the following Docker command on your host:

- Prepare persistent volume

```bash
sudo mkdir /opt/rancher
sudo chmod 755 /opt/rancher
```

- Make copy of `.kube/config` from Kubernetes cluster's master-node

```bash
# Rancher node
mkdir ~/.kube

# Copy the kube cluster config to Rancher node
scp root@master:/etc/kubernetes/admin.conf ~/.kube/config
```

- Check cluster status

```
kubectl cluster-info

kubectl get nodes

kubectl version --short
```

## Install Rancher

Remember, that running the Rancher server uses port 8888 and 4443 to avoid conflicts if the Rancher server and Master server is on the same VM.

```bash
docker run -d --restart=unless-stopped -p 8888:80 -p 4443:443 -v /opt/rancher:/var/lib/rancher \
  --name rancher rancher/rancher:latest
# rancher/rancher:stable
# rancher/rancher:latest

# Container name: rancher
# Persistent volume: /opt/rancher
```

To stop rancher server container before shutting down your VM

```bash
docker stop rancher
```

#### Initialize `server-url`

For Rancher in VirtualBox, set `server-url` to Rancher Server's static IP address: 192.168.1.120 (for example). Rancher `server-url` in local VirtualBox must be static IP address in order to support the networking.

#### Reset admin password

```bash
$ docker exec -ti <container_id> reset-password
New password for default administrator (user-xxxxx):
<new_password>

# Execute
docker exec -ti ec437235159b reset-password

# Output
New password for default administrator (user-xxxxx):
t3JtbLuvr9Ths-pHVp3S
```

#### Check logs for errors

```bash
docker logs -f rancher
```

- To access the Rancher server UI, open a browser and go to the hostname or address where the container was installed. You will be guided through setting up your first cluster.
  If you run Rancher and K8s Cluster on local environment with VirtualBox VMs, you must set `server-url` to be the Rancher node's `ip address`, for example:

```bash
# server-url
https://192.168.56.3

# username: admin
```

Note, that Rancher uses DNS Service to resolve hostname, therefore, configuring `/etc/hosts` will not help. You must use `ip address` for running it locally.

#### Verify the Rancher can connect to the cluster.

- `cattle-node-agent`

```bash
# Check if the cattle-node-agent pods are present on each node, have status Running and don’t have a high count of Restarts:
kubectl -n cattle-system get pods -l app=cattle-agent -o wide

# Check logging of a specific cattle-node-agent pod or all cattle-node-agent pods:
kubectl -n cattle-system logs -l app=cattle-agent
```

- `cattle-cluster-agent`

```bash
# Check if the cattle-cluster-agent pod is present in the cluster, has status Running and doesn’t have a high count of Restarts:
kubectl -n cattle-system get pods -l app=cattle-cluster-agent -o wide

# Check logging of cattle-cluster-agent pod:
kubectl -n cattle-system logs -l app=cattle-cluster-agent
```

## Add Cluster - Import (from existing cluster) | Custom (preferred)

- Run the kubectl command below on an existing Kubernetes cluster running a supported Kubernetes version to import it into Rancher:

```bash
# You've got the command from the Rancher UI

# Sample 1
curl --insecure -sfL https://master:4443/v3/import/qcqjcwmggp9lzjpt6k8nw788gmhr9zqwhj2vcwqpdfz4gxq6t4p9fv.yaml | kubectl apply -f -

# Sample 2 - Home
curl --insecure -sfL https://master:4443/v3/import/w8tfj4xs7nwd622g5bcjvbtmhvc985q8c7glgkz6c69h9626t5bb64.yaml | kubectl apply -f -
```

## Reference

- Rancher Quick Start, https://rancher.com/quick-start/
- Rancher Quick Start Guide, https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/

- Some `kubectl` commands:

```
kubectl version --short

watch kubectl get namespaces

watch kubectl -n cattle-system get all -o wide

watch kubectl get all -o wide
```

- Manual Quick Start, https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/deployment/quickstart-manual-setup/
- Adding Ingresses to Your Project, https://rancher.com/docs/rancher/v2.x/en/k8s-in-rancher/load-balancers-and-ingress/ingress/

## Create a new Kubernetes Cluster from Rancher

1. Run the Kubernetes docker command on the Master node first, please wait until the cluster is successfully created;
2. Then, Run the Kubernetes docker command on the Worker node to join the cluster

```
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.3.4 --server https://master:8443 --token xgdhnpqvxsh4cmj9t5s4wtkgfrh5qz8v5zhpj2qhmrmvgmdfvctvll --ca-checksum 7902375b8b50ceaeec92d0980e4635d24be0f463e3e5bc2e3f5b49a460446bbb --etcd --controlplane --worker
```

## Deploy a Sample App

- See `example-voting-app-kubernetes-v2` from github
- OR: See `https://github.com/MikeQin/k8s-voting-app.git`
