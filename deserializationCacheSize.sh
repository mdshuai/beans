#!/bin/bash

#create 20 secret
oc delete project dma
sleep 5
oadm new-project dma
sleep 5
for i in `seq 1 1 20`; do oc new-app -f https://raw.githubusercontent.com/mdshuai/testfile-openshift/master/large-secret.yaml -p SECRETNAME=cache-secret$i -n dma; done

#update every secret's annotation every 3s
i=100

while true
do
  sleep 3
  for j in `seq 1 1 20`; do oc patch secret/cache-secret$j -p '{"metadata":{"annotations":{"test":"'$i'"}}}' -n dma; done
  i=`expr $i + 1`
done

#In another terminal run the command & watch openshift master memory usage
#ps auxw|head -1; for i in `seq 1 1 10000`;do ps auxw --no-header|grep "openshift start master"|head -1; sleep 10; done
