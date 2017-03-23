## Deploy federatoin on aws
* #### Prepare hyperkube image for federation
```
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes
make quick-release
cd cluster/images/hyperkube
make build VERSION=latest ARCH=amd64
docker tag gcr.io/google_containers/hyperkube-amd64 deshuai/hyperkube-amd64:latest
```
* #### Deploy federation
1. make sure enable cloud-provider
2. make sure your account can create load balance svc
3. create a route53 host zone
4. use kubefed deploy federation env
```
# kubefed init myfed --dns-provider=aws-route53 --dns-zone-name=federation.qe.com --etcd-persistent-storage=false --image=docker.io/deshuai/hyperkube-amd64:latest
Federation API server is running at: a47c0139a0f9611e7a15f0e70ee9b7fa-524663631.us-east-1.elb.amazonaws.com
```

* #### Confirm federation deploy success
```
[root@ip-172-18-13-114 ~]# kubectl get ns
NAME                STATUS    AGE
default             Active    45s
federation-system   Active    20s
kube-public         Active    44s
kube-system         Active    45s
[root@ip-172-18-13-114 ~]# kubectl get svc -n federation-system
NAME              CLUSTER-IP   EXTERNAL-IP        PORT(S)         AGE
myfed-apiserver   10.0.0.194   a47c0139a0f96...   443:32179/TCP   31s
[root@ip-172-18-13-114 ~]# kubectl get pod -n federation-system
NAME                                        READY     STATUS    RESTARTS   AGE
myfed-apiserver-744151201-00hwj             2/2       Running   0          43s
myfed-controller-manager-4030135593-jlznz   1/1       Running   0          43s
```
