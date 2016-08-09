#/bin/bash 

#build latest monitor binay and image
export PATH=$PATH:$GOPATH/bin
go get github.com/tools/godep
go get -d k8s.io/heapster
cd $GOPATH/src/k8s.io/heapster
make

cd $GOPATH/src/k8s.io/heapster/deploy/docker
./build.sh

cd $GOPATH/src/k8s.io/heapster/influxdb
./build.sh

cd $GOPATH/src/k8s.io/heapster/grafana
make

#After finish build image, re-tag
docker tag heapster:canary docker.io/deshuai/heapster:canary
docker tag heapster_influxdb:canary docker.io/deshuai/heapster_influxdb:canary 
docker tag kubernetes/heapster_grafana:v2.6.0-2 docker.io/deshuai/heapster_grafana:v2.6.0-2

#deploy monitor
cd $GOPATH/src/k8s.io/heapster/deploy/kube-config/influxdb/
sed -i -e 's/kubernetes\/heapster:canary/docker.io\/deshuai\/heapster:canary/g' heapster-controller.yaml
sed -i -e 's/kubernetes\/heapster_influxdb:v0.5/docker.io\/deshuai\/heapster_influxdb:canary/g' influxdb-grafana-controller.yaml
sed -i -e 's/gcr.io\/google_containers\/heapster_grafana:v2.6.0-2/docker.io\/deshuai\/heapster_grafana:v2.6.0-2/g' influxdb-grafana-controller.yaml
kubectl create -f ./
cd -

#check cluster-monitoring working
sleep 10
kubectl get pod --namespace=kube-system
