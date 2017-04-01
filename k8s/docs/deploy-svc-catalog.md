## Deploy svc-catalog in k8s

1. Make sure you have a k8s cluster and enalbe dns. Example we can launch a quick all-in-one env as below
```
KUBE_ENABLE_CLUSTER_DNS=true hack/local-up-cluster.sh -O
```

2. install glide
```
go get github.com/Masterminds/glide
```

3. install helm & make sure tiller is running
```
go get k8s.io/helm
helm init
# kubectl get pod -n kube-system
NAME                             READY     STATUS    RESTARTS   AGE
kube-dns-806549836-lt3g2         3/3       Running   0          11m
tiller-deploy-1012751306-cm57x   1/1       Running   0          11m

```
4. build svc-catalog binary&iamge
```
git clone https://github.com/kubernetes-incubator/service-catalog.git
cd service-catalog
make build
export REGISTRY="docker.io/deshuai/"
make images
make push
```

5. deploy svc-catalog & ups-broker in kubernetes cluster
```
cd ..
export APISERVER_IMAGE=docker.io/deshuai/apiserver:canary
export CONTROLLER_IMAGE=docker.io/deshuai/controller-manager:canary
export UPSBROKER_IMAGE=docker.io/deshuai/user-broker:canary
helm install service-catalog/charts/catalog --name catalog --set apiserver.image=${APISERVER_IMAGE} --set controllerManager.image=${CONTROLLER_IMAGE} --namespace catalog
helm install service-catalog/charts/ups-broker --name ups-broker --set image=${UPSBROKER_IMAGE} --namespace ups-broker

[root@ip-172-18-13-114 kubernetes-incubator]# kubectl get pod -n catalog
NAME                                                 READY     STATUS    RESTARTS   AGE
catalog-catalog-apiserver-2950627526-hfgc4           2/2       Running   0          16m
catalog-catalog-controller-manager-401374867-d73dq   1/1       Running   1          16m
[root@ip-172-18-13-114 kubernetes-incubator]# kubectl get pod -n ups-broker
NAME                                     READY     STATUS    RESTARTS   AGE
ups-broker-ups-broker-3359185601-0psrl   1/1       Running   0          16m
```

6. Confirm svc-catalog deploy success and works well.
```
APISERVER=`kubectl get svc --no-headers -n catalog | awk '{print $2}'`
kubectl config set-cluster service-catalog --server=http://${APISERVER}:80
kubectl config set-context service-catalog --cluster=service-catalog
alias kc='kubectl --context=service-catalog'
kc get brokers,serviceclasses,instances,bindings
[root@ip-172-18-13-114 kubernetes-incubator]# kc get brokers,serviceclasses,instances,bindings
No resources found.
```

7. (optional)you can also use direnv to exchange for different kubectl cluster.
```
go get github.com/direnv/direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
//In service-catalog dir
cat > .envrc <<EOF
export REGISTRY="hub.docker.io/deshuai"
export KUBECONFIG=/service-catalog/.kubeconfig
EOF
```
8. Now you can begin [walkthrough](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/walkthrough.md#step-5---creating-a-broker-resource)
