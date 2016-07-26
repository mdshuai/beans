#!/bin/bash

export PATH=$PATH:$GOPATH/bin
go get github.com/tools/godep
go get -d k8s.io/heapster
cd $GOPATH/src/k8s.io/heapster
make
