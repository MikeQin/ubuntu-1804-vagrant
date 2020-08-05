# Yugabyte

## YugabyteDB on Kubernetes in Action

### Step 1 – Download the YugabyteDB Kubernetes YAML
```
mkdir ~/yugabyte && cd ~/yugabyte
wget https://raw.githubusercontent.com/YugaByte/yugabyte-db/master/cloud/kubernetes/yugabyte-statefulset.yaml
```

### Step 2 – Change the yb-tserver replica count from 3 to 4
Open the the YAML in the editor of your choice and set the yb-tserver replica count to 4.
```
spec:
  serviceName: yb-tservers
  podManagementPolicy: "Parallel"
  replicas: 4
```
### Step 3 – Create the DB cluster
Now you can create the YugabyteDB cluster through the following command.
```
kubectl apply -f yugabyte-statefulset.yaml
```

### Step 4 – Check status of the pods and services
Since Kubernetes has to first pull the yugabytedb/yugabyte image from hub.docker.com, the cluster may take a few minutes to become live. You can check the status using the following commands.
```
kubectl get pods
```
```
NAME           READY     STATUS              RESTARTS   AGE
yb-master-0    0/1       ContainerCreating   0          7s
yb-master-1    0/1       ContainerCreating   0          7s
yb-master-2    0/1       ContainerCreating   0          7s
yb-tserver-0   0/1       ContainerCreating   0          7s
yb-tserver-1   0/1       ContainerCreating   0          7s
yb-tserver-2   0/1       ContainerCreating   0          7s
yb-tserver-3   0/1       ContainerCreating   0          7s
```

When the cluster is ready, it will have all the 7 pods (3 for yb-master and 4 for yb-tserver) in the Running status.
```
NAME           READY     STATUS    RESTARTS   AGE
yb-master-0    1/1       Running   0          7m
yb-master-1    1/1       Running   0          7m
yb-master-2    1/1       Running   0          7m
yb-tserver-0   1/1       Running   0          7m
yb-tserver-1   1/1       Running   0          7m
yb-tserver-2   1/1       Running   0          7m
yb-tserver-3   1/1       Running   0          7m
```

You can also check the status of the 3 services we launched along with the status of the default kubernetes service itself.

```
kubectl get services
NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
kubernetes ClusterIP 10.96.0.1 443/TCP 10m
yb-master-ui LoadBalancer 10.102.121.64 7000:31283/TCP 8m
yb-masters ClusterIP None 7000/TCP,7100/TCP 8m
yb-tservers ClusterIP None 9000/TCP,9100/TCP,9042/TCP,6379/TCP 8m
```

Finally, you can view the nice UI dashboard provided by Kubernetes and Rancher.

### Step 5 – View the YB-Master Admin UI
Once the cluster is live, you can launch the YB-Master Admin UI.

### Step 6 – Perform Day 2 Operational Tasks
The next few steps show how to perform common day 2 operational tasks such as adding/removing nodes and performing rolling upgrades. All these operations do not impact the availability and performance of client applications thus allowing the applications to continue to operate normally.

#### Add a Node
Horizontal scaling is a breeze with YugabyteDB and with Kubernetes, the process could not be simpler. All we have to do is to let Kubernetes know how many replicas to scale to.
```
kubectl scale statefulset yb-tserver --replicas=5
```
```
statefulset "yb-tserver" scaled
```
Now we can check the status of the scaling operation. Note that YugabyteDB automatically moves a few tablet-leaders and a few tablet-followers into the newly added node so that the cluster remains balanced across all the nodes.
```
kubectl get pods
```

#### Remove Two Nodes

Removing nodes is also very simple. Reduce the number of replicas and see the combination of Kubernetes and YugabyteDB do the rest.
```
kubectl scale statefulset yb-tserver --replicas=3
```
```
statefulset "yb-tserver" scaled
```
As expected in StatefulSets, we can see that the nodes with the largest ordinal indexes (i.e. 4 and 3) are removed first.
```
kubectl get pods
```

#### Perform Rolling Upgrade
We can also perform rolling upgrades on the YugabyteDB cluster. This involves changing the YugabyteDB container image to a different version first on the yb-master StatefulSet and then on the yb-tserver StatefulSet. As expected in StatefulSets, we can see that the nodes with the largest ordinal indexes are upgraded first.

Upgrading the yb-master StatefulSet uses the command below. Assuming the new container image is not already available with Kubernetes, the image will be pulled from hub.docker.com first and this may result in the first pod upgrade taking a few minutes.

```
kubectl patch statefulset yb-master --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"yugabytedb/yugabyte:1.0.4.0-b24"}]'
```

Now we can upgrade the yb-tserver StatefulSet as well. This will lead to the yb-tserver pods getting upgraded in the same way we saw for the yb-master pods.

```
kubectl patch statefulset yb-tserver --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"yugabytedb/yugabyte:1.0.4.0-b24"}]'
```

### Summary
Running distributed databases using a distributed orchestration technology such as Kubernetes continues to remain a non-trivial problem. YugabyteDB is a distributed database with a unique sharding and replication architecture that makes it a perfect fit for Kubernetes-based orchestration. In this post, we reviewed the underlying details of how YugabyteDB runs on Kubernetes and how this looks in action in the context of a real cluster. As part of our upcoming 1.1 release, we expect to release additional Kubernetes-related enhancements such as running the YugabyteDB Enterprise Admin Console on the same Kubernetes cluster as YugabyteDB. Subscribe to our blog at the bottom of this page and stay tuned with our progress.

### Reference
- https://blog.yugabyte.com/understanding-how-yugabyte-db-runs-on-kubernetes/

## Create a single node cluster

https://docs.yugabyte.com/latest/quick-start/create-local-cluster/docker/#overview-and-yb-master-status

```
docker run -d --name yugabyte  -p7000:7000 -p9000:9000 -p5433:5433 -p9042:9042\
 -v ~/yb_data:/home/yugabyte/var\
 yugabytedb/yugabyte:latest bin/yugabyted start\
 --daemon=false 
```

Check status:  http://localhost:9000