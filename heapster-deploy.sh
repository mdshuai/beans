#/bin/bash 

#build latest monitor binay and image
export PATH=$PATH:$GOPATH/bin
go get github.com/tools/godep
go get -d k8s.io/heapster
cd $GOPATH/src/k8s.io/heapster
make

#old build method
#cd $GOPATH/src/k8s.io/heapster/deploy/docker
#./build.sh
#cd $GOPATH/src/k8s.io/heapster/influxdb
#./build.sh
#cd $GOPATH/src/k8s.io/heapster/grafana
#make

#latest build method
PREFIX=docker.io/deshuai make container grafana influxdb

#After finish build image, re-tag
docker tag heapster:canary docker.io/ocpqe/heapster:canary
docker tag heapster_influxdb:canary docker.io/ocpqe/heapster_influxdb:canary 
docker tag gcr.io/google_containers/heapster_grafana:v3.1.1 docker.io/ocpqe/heapster_grafana:v3.1.1

#deploy monitor
cd $GOPATH/src/k8s.io/heapster/deploy/kube-config/influxdb/
sed -i -e 's/kubernetes\/heapster:canary/docker.io\/ocpqe\/heapster:canary/g' heapster-deployment.yaml
sed -i -e 's/kubernetes\/heapster_influxdb:v0.6/docker.io\/ocpqe\/heapster_influxdb:canary/g' influxdb-deployment.yaml
sed -i -e 's/gcr.io\/google_containers\/heapster_grafana:v3.1.1/docker.io\/ocpqe\/heapster_grafana:v3.1.1/g' grafana-deployment.yaml
kubectl create -f ./
cd -

#check cluster-monitoring working
sleep 10
kubectl get pod --namespace=kube-system
