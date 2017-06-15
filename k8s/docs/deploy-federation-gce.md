### 1. Prepare: gce instance
1) need update NetworkTags, otherwise it will failed to create lb svc
2) after update instance 'Network tags', you need create related 'Firewall rules'
3) you need use the serviceaccount 'aos-serviceaccount'
4) need use staic ip for gce instance

### 2. Build federation image
```
# mkdir dma && cd dma
# cat <<EOF > Dockerfile 
FROM <registry>/openshift3/ose-base
Add hypercube /usr/bin/hyperkube
Run ln -s /usr/bin/hyperkube /hyperkube

LABEL io.k8s.display-name="OpenShift Origin Federation" \
      io.k8s.description="This is a component of OpenShift Origin and contains the software for running federation servers."
EOF
# yum install atomic-openshift-federation-services
# cp /usr/bin/hyperkube ./
# docker build -t docker.io/deshuai/ose-federation:v3.6.101 .
# docker tag docker.io/deshuai/ose-federation:v3.6.101 docker.io/deshuai/ose-federation:latest
# docker push docker.io/deshuai/ose-federation:v3.6.101
# docker push docker.io/deshuai/ose-federation:latest
```

### 3. Deploy federation, when complete will create cluster/context in the local kubeconfig file named myfed.
```/bin/bash
# kubefed init myfed --dns-provider=google-clouddns --dns-zone-name=federation.ocpqe.com. --etcd-persistent-storage=false --image=docker.io/deshuai/ose-federation:latest
# oadm --namespace federation-system policy add-role-to-user admin system:serviceaccount:federation-system:default
# oadm --namespace federation-system policy add-role-to-user admin system:serviceaccount:federation-system:federation-controller-manager
# oadm policy add-scc-to-user anyuid system:serviceaccount:federation-system:deployer -n federation-system
# oadm policy add-scc-to-user anyuid system:serviceaccount:federation-system:default -n federation-system
# oc patch deployment myfed-apiserver -n federation-system -p '{"spec": {"template": {"spec": {"securityContext": {"runAsUser": 0}}}}}'
```

```/bin/bash
[root@qe-dma36-master-1 federation]# oc get svc -n federation-system
NAME              CLUSTER-IP     EXTERNAL-IP       PORT(S)         AGE
myfed-apiserver   172.30.156.5   xxx.xxx.xxx.xxx   443:31651/TCP   49m
[root@qe-dma36-master-1 federation]# oc get deployment -n federation-system
NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
myfed-apiserver            1         1         1            1           48m
myfed-controller-manager   1         1         1            1           48m
[root@qe-dma36-master-1 federation]# oc get pod -n federation-system
NAME                                        READY     STATUS    RESTARTS   AGE
myfed-apiserver-1603727799-f2mn6            2/2       Running   0          16m
myfed-controller-manager-2334921758-b88g6   1/1       Running   0          15m
[root@qe-dma36-master-1 federation]# kubefed init myfed --dns-provider=google-clouddns --dns-zone-name=federation.ocpqe.com. --etcd-persistent-storage=false --image=docker.io/deshuai/ose-federation:latest
Federation API server is running at: xxx.xxx.xxx.xxx
```

### 4. Join cluster
//when run `kubefed join` Current context is assumed to be a federation API server. Please use the --context flag otherwise

//host-context is where fedration pod located.
```
# export CLUSTER1_CONTEXT=default/preserved-dma-cluster1-master-1-0609-k0d-qe-rhcloud-com:8443/system:admin
# export CLUSTER2_CONTEXT=default/preserved-dma-cluster2-master-1-0609-sok-qe-rhcloud-com:8443/system:admin
# export HOST_CONTEXT=${CLUSTER2_CONTEXT}
# kubefed join cluster1 --cluster-context=${CLUSTER1_CONTEXT} --host-cluster-context=${HOST_CONTEXT} --context=myfed
cluster "cluster1" created
# kubefed join cluster2 --cluster-context=${CLUSTER2_CONTEXT} --host-cluster-context=${HOST_CONTEXT} --context=myfed
cluster "cluster2" created
```

```/bin/bash
[root@preserved-dma-cluster2-master-1 federation]# oc get cluster --context=myfed
NAME       STATUS    AGE
cluster1   Ready     18s
cluster2   Ready     16s
[root@preserved-dma-cluster2-master-1 federation]# oc describe cluster cluster1 --context=myfed
Name:	cluster1
Labels:	<none>
ServerAddressByClientCIDRs:
  ClientCIDR	ServerAddress
  ----		----
  0.0.0.0/0 	https://preserved-dma-cluster1-master-1.0609-k0d.qe.rhcloud.com:8443

Conditions:
  Type		Status	LastUpdateTime				LastTransitionTime			Reason		Message
  ----		------	-----------------			------------------			------		-------
  Ready 	True 	Mon, 12 Jun 2017 18:38:31 -0400 	Mon, 12 Jun 2017 18:37:51 -0400 	ClusterReady 	/healthz responded with ok
[root@preserved-dma-cluster2-master-1 federation]# oc describe cluster cluster2 --context=myfed
Name:	cluster2
Labels:	<none>
ServerAddressByClientCIDRs:
  ClientCIDR	ServerAddress
  ----		----
  0.0.0.0/0 	https://preserved-dma-cluster2-master-1.0609-sok.qe.rhcloud.com:8443

Conditions:
  Type		Status	LastUpdateTime				LastTransitionTime			Reason		Message
  ----		------	-----------------			------------------			------		-------
  Ready 	True 	Mon, 12 Jun 2017 18:38:31 -0400 	Mon, 12 Jun 2017 18:37:51 -0400 	ClusterReady 	/healthz responded with ok
```

### 5. Run federation e2e
```
//options
# cd /roo
# git clone --depth=1 https://github.com/openshift/origin
# export KUBECONFIG=/etc/origin/master/admin.kubeconfig
# export KUBE_REPO_ROOT=/root/origin/vendor/k8s.io/kubernetes
# export EXTENDED_TEST_PATH=/root/origin/test/extended
```
```
//run federation extend test
# yum install atomic-openshift-tests
# extended.test --ginkgo.v --ginkgo.focus="Feature:Federation" --federation-config-from-cluster=true --federated-kube-context=myfed
```
### 6. Debug issue
1) etcdmain: cannot access data directory: mkdir /var/etcd/data: permission denied
`oadm policy add-scc-to-user anyuid system:serviceaccount:federation-system:deployer -n federation-system`

`oadm policy add-scc-to-user anyuid system:serviceaccount:federation-system:default -n federation-system`

2) Cluster is Unknow after join, check controller-manager log: error in fetching secret: 
User "system:serviceaccount:federation-system:federation-controller-manager" cannot get secrets in project "federation-system"

solution: `oadm --namespace federation-system policy add-role-to-user admin system:serviceaccount:federation-system:federation-controller-manager`
