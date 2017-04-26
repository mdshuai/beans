## Deploy [kube-aggregator](https://github.com/kubernetes/kube-aggregator)
```
cd $KUBERNETES_SRC_DIR
cd staging/src/k8s.io/kube-aggregator/
hack/build-image.sh
hack/local-up-kube-aggregator.sh

[root@ip-172-18-13-114 kube-aggregator]# kubectl get po -n kube-public
NAME                    READY     STATUS    RESTARTS   AGE
etcd-lgp6b              1/1       Running   0          1m
kube-aggregator-061jz   1/1       Running   0          1m
```
