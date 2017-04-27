### sample-apiserver

Note: After [combine kube-apiserver and kube-aggregator](https://github.com/kubernetes/kubernetes/pull/42911), no need deploy kube-aggregator as a pod again. This will works in 1.7

```
kubectl create ns wardle
cd staging/src/k8s.io/sample-apiserver/
go build .
cp sample-apiserver artifacts/simple-image/kube-sample-apiserver
hack/build-image.sh

docker tag kube-sample-apiserver:latest docker.io/deshuai/kube-sample-apiserver:latest
docker push docker.io/deshuai/kube-sample-apiserver:latest

cd artifacts/example
kubectl create -f auth-delegator.yaml  auth-reader.yaml  rc.yaml  sa.yaml  service.yaml

[root@ip-172-18-13-114 sample-apiserver]# kubectl get pod -n wardle
NAME                  READY     STATUS    RESTARTS   AGE
wardle-server-vj8cf   2/2       Running   0          7m

#when the sample-apiserve running
[root@ip-172-18-13-114 sample-apiserver]# kubectl get flunders
the server doesn't have a resource type "flunders"

#register the apis supplied by sample-apiserver
kubectl create -f apiservice.yaml
[root@ip-172-18-13-114 example]# kubectl get apiservices | grep wardle
v1alpha1.wardle.k8s.io               APIService.v1alpha1.apiregistration.k8s.io

#now we can get flunders resource
[root@ip-172-18-13-114 example]# kubectl get flunders
No resources found.

#create flunders and confirm it real
[root@ip-172-18-13-114 artifacts]# cat flunders/01-flunder.yaml 
apiVersion: wardle.k8s.io/v1alpha1
kind: Flunder
metadata:
  name: my-first-flunder
  labels:
    sample-label: "true"
[root@ip-172-18-13-114 artifacts]# kubectl create -f flunders/01-flunder.yaml 
flunder "my-first-flunder" created
[root@ip-172-18-13-114 artifacts]# kubectl get flunder
NAME               KIND
my-first-flunder   Flunder.v1alpha1.wardle.k8s.io

#Conclusion, the Flunder object we created was saved in the separate etcd instance!
[root@ip-172-18-13-114 artifacts]# kubectl exec -it wardle-server-vj8cf -c etcd -n wardle -- /bin/sh
/ # ETCDCTL_API=3 etcdctl get /registry/wardle.kubernetes.io/registry/wardle.kub
ernetes.io/wardle.k8s.io/flunders/my-first-flunder
/registry/wardle.kubernetes.io/registry/wardle.kubernetes.io/wardle.k8s.io/flunders/my-first-flunder
{"kind":"Flunder","apiVersion":"wardle.k8s.io/v1alpha1","metadata":{"name":"my-first-flunder","uid":"b609626d-2b2a-11e7-bfd4-0242ac110003","creationTimestamp":"2017-04-27T09:20:10Z","labels":{"sample-label":"true"}},"spec":{},"status":{}}
```
