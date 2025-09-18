# How to run Redis Cluster with Terraform

```shell
terraform plan
terraform apply
```

```shell
kubectl get pods --all-namespaces
```

### Run redis client
```shell
kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=redispassword123  --image docker.io/bitnamilegacy/redis:7.2 --command -- sleep infinity
```

### Connect to the client

```shell
kubectl exec --tty -i redis-client --namespace default -- bash
```

### Connect to master or replica

```shell
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-cluster-master
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-cluster-replicas
```
### Set a value

```shell
SET mykey "Hello, Redis!"
GET mykey
```

# Ho to get additional information about release
It also includes info how to use `kubectl` to connect to the server
```shell
helm status <ReleaseName> -n <Namespace>
```
Example
```shell
helm status redis-cluster -n default
```


# How to install\uninstall Redis manually using Helm:

```shell
helm repo ls
```
```Log
NAME            URL                                     
bitnami         https://charts.bitnami.com/bitnami
```

### Create a helm release (single host)
```shell
helm install redis bitnami/redis
```

You can try this one and see what you get
```shell
helm install redis bitnami/redis --verify --debug
```


```shell
helm ls
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
redis   default         1               2025-09-18 12:35:42.7619144 +0200 CAT   deployed        redis-22.0.7    8.2.1
```

### Uninstall helm release
```shell
helm uninstall redis bitnami/redis
```

# Troubleshooting

This section was added before I found that `bitnami` repository was moved to `bitnamilegacy` (see `values.yaml` file)

```shell
helm search repo bitnami/redis --versions
```

 Where 22.0.7 is a chart version
```shell
helm pull bitnami/redis --version 22.0.7
```

When run "terraform plan" see what the flag of "verify" property
Try to run the following command with and without --verify
```shell
helm install redis bitnami/redis --verify --debug
```

```shell
kubectl get pods --all-namespaces
# or 
kubectl get pods -n redis 
```
```shell
kubectl describe pod redis-master-0 -n redis
```

## How to list available values
```shell
 helm show values bitnami/redis --version 22.0.7
```

### Ho to get additional information about release 
It also includes info how to use `kubectl` to connect to the server
```shell
helm status <ReleaseName> -n <Namespace>
```
Example
```shell
helm status redis-cluster -n default
```
where `redis-cluster` is the release name

## Find what image cannot be pulled

Find the image and registry url
```shell
kubectl describe pod redis-cluster-master-0
```

```log
Events:
Type     Reason     Age   From               Message
  ----     ------     ----  ----               -------
Normal   Scheduled  6s    default-scheduler  Successfully assigned default/redis-cluster-master-0 to docker-desktop  
Normal   Pulling    5s    kubelet            Pulling image "ghcr.io/bitnami/redis:7.4"  
Warning  Failed     3s    kubelet            Failed to pull image "ghcr.io/bitnami/redis:7.4": Error response from daemon: error from registry: denied  
denied  
Warning  Failed   3s               kubelet  Error: ErrImagePull  
Normal   BackOff  1s (x2 over 2s)  kubelet  Back-off pulling image "ghcr.io/bitnami/redis:7.4"  
Warning  Failed   1s (x2 over 2s)  kubelet  Error: ImagePullBackOff
```


Try to pull the image manually
```shell
docker pull bitnami/redis
#Using default tag: latest
#Error response from daemon: failed to resolve reference "docker.io/bitnami/redis:latest": docker.io/bitnami/redis:latest: not found
```

```shell
docker pull redis:7.2
```
Result:
```log
7.2: Pulling from library/redis  
0068d69ba790: Pull complete  
...  
...  
Digest: sha256:80f52338282f0b18caafcab372e816b3e11bca49d503c00db96799d6a12131b7  
Status: Downloaded newer image for redis:7.2  
docker.io/library/redis:7.2```


!!!!!!!!!! Bitnami repo moved to `docker.io/bitnamilegacy`
```shell
docker pull docker.io/bitnamilegacy/redis-cluster:7.2
```

# Links
Redis operators:
- https://operatorhub.io/
- https://artifacthub.io/