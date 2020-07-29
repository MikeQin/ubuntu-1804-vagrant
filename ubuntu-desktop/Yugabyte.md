# Yugabyte

## Create a single node cluster

https://docs.yugabyte.com/latest/quick-start/create-local-cluster/docker/#overview-and-yb-master-status

```
docker run -d --name yugabyte  -p7000:7000 -p9000:9000 -p5433:5433 -p9042:9042\
 -v ~/yb_data:/home/yugabyte/var\
 yugabytedb/yugabyte:latest bin/yugabyted start\
 --daemon=false 
```

Check status:  http://localhost:9000