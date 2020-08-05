# Helm Quickstart Guide

## Helm Chart Basic

### Initialize a Helm Chart Repository
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

### List the charts you can install
helm search repo stable

### Update repo
```
helm repo update
```

### Install an Example Chart
```
helm install stable/mysql --generate-name

# You get a simple idea of the features of this MySQL chart
helm show chart stable/mysql
# To get all information about the chart
helm show all stable/mysql
```

### Learn About Releases
```
$ helm ls
NAME             VERSION   UPDATED                   STATUS    CHART
smiling-penguin  1         Wed Sep 28 12:59:46 2016  DEPLOYED  mysql-0.1.0
```

### Uninstall a Release
To uninstall a release, use the helm uninstall command:
```
$ helm uninstall smiling-penguin
Removed smiling-penguin
```
```
$ helm status smiling-penguin
Status: UNINSTALLED
```

## Yugabyte

Reference:
- Open source Kubernetes: https://docs.yugabyte.com/latest/deploy/kubernetes/single-zone/oss/helm-chart/#check-the-cluster-status

### Add charts repository
```
helm repo add yugabytedb https://charts.yugabyte.com
```
```
helm repo update
```

### Validate the chart version
```
helm search repo yugabytedb/yugabyte
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
yugabytedb/yugabyte     2.2.0           2.2.0.0-b80     YugabyteDB is the high-performance distributed ...
```

### Create a namespace
```
kubectl create namespace yb-demo
```

### Install yugabyte Helm Chart

##### On multi-node Kubernetes
```
helm install yb-demo yugabytedb/yugabyte --namespace yb-demo --wait
```

##### On Minikube
Note that in Minikube, the LoadBalancers for yb-master-ui and yb-tserver-service will remain in pending state since load balancers are not available in a minikube environment. If you would like to turn off these services simply pass the enableLoadBalancer=False flag as shown below.
```
helm install yb-demo yugabytedb/yugabyte \
--set resource.master.requests.cpu=0.5,resource.master.requests.memory=0.5Gi,\
resource.tserver.requests.cpu=0.5,resource.tserver.requests.memory=0.5Gi,\
enableLoadBalancer=False --namespace yb-demo
```

#### Check the cluster status
You can check the status of the cluster using various commands noted below.
```
$ helm status yb-demo -n yb-demo
```

Check the pods.
```
$ kubectl get pods --namespace yb-demo
```

Check the services.
```
$ kubectl get services --namespace yb-demo
```

You can also check the history of the yb-demo deployment.
```
$ helm history yb-demo -n yb-demo
```

#### Output

```
vagrant@master:~$ helm status yb-demo -n yb-demo
NAME: yb-demo
LAST DEPLOYED: Tue Aug  4 04:27:46 2020
NAMESPACE: yb-demo
STATUS: failed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get YugabyteDB Pods by running this command:
  kubectl --namespace yb-demo get pods

2. Get list of YugabyteDB services that are running:
  kubectl --namespace yb-demo get services

3. Get information about the load balancer services:
  kubectl get svc --namespace yb-demo

4. Connect to one of the tablet server:
  kubectl exec --namespace yb-demo -it yb-tserver-0 bash

5. Run YSQL shell from inside of a tablet server:
  kubectl exec --namespace yb-demo -it yb-tserver-0 -- /home/yugabyte/bin/ysqlsh -h yb-tserver-0.yb-tservers.yb-demo

6. Cleanup YugabyteDB Pods
  For helm 2:
  helm delete yb-demo --purge
  For helm 3:
  helm delete yb-demo -n yb-demo
  NOTE: You need to manually delete the persistent volume
  kubectl delete pvc --namespace yb-demo -l app=yb-master
  kubectl delete pvc --namespace yb-demo -l app=yb-tserver
```

#### Uninstall
```
helm ls

# Use the name found above
helm uninstall [helm_release_name]
```