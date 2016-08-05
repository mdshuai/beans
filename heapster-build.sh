#/bin/bash 
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/kubernetes/_output/bin/

#deploy local k8s with kube-dns
cd ~/
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes
export KUBERNETES_PROVIDER=local
export KUBE_ENABLE_CLUSTER_DNS=true
export KUBELET_HOST=172.18.12.44
export API_HOST=172.17.0.1
export HOSTNAME_OVERRIDE=172.18.12.44

hack/local-up-cluster.sh

#build latest monitor binay and image
export PATH=$PATH:$GOPATH/bin
go get github.com/tools/godep
go get -d k8s.io/heapster
cd $GOPATH/src/k8s.io/heapster
make

cd $GOPATH/src/k8s.io/heapster/ deploy/docker
./build.sh

cd $GOPATH/src/k8s.io/heapster/influxdb
./build.sh

cd $GOPATH/src/k8s.io/heapster/grafana
./build.sh

#deploy monitor
cd $GOPATH/src/k8s.io/heapster
sed -i -e 's/kubernetes\/heapster_influxdb:v0.5/kubernetes\/heapster_influxdb:canary/g' influxdb-grafana-controller.yaml
sed -i -e 's/gcr.io\/google_containers\/heapster_grafana:v2.6.0-2/gcr.io\/google_containers\/heapster_grafana:canary/g' influxdb-grafana-controller.yaml
kubectl create -f deploy/kube-config/influxdb/

#check cluster-monitoring working
sleep 10
kubectl get pod --namespace=kube-system
