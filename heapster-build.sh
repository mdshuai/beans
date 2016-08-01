#!/bin/bash

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
