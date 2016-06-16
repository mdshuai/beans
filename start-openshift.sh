#!/bin/bash

#supose openshift command already in the path

public_master=$1
echo $public_master
mkdir logs
openshift start --write-config=openshift.local.config --public-master=https://${public_master}:8443
sleep 5
openshift start master --config=openshift.local.config/master/master-config.yaml --loglevel=5 &> logs/openshift-master.log &

nodeConfig=$(ls openshift.local.config |grep node)
openshift start node --config=openshift.local.config/${nodeConfig}/node-config.yaml --loglevel=5 &> logs/openshift-node.log &

#export PATH=$PATH:/data/src/github.com/openshift/origin/_output/local/bin/linux/amd64

export KUBECONFIG=`pwd`/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=`pwd`/openshift.local.config/master/ca.crt

sudo chmod a+rwX "$KUBECONFIG"
#sudo chmod +r ./openshift.local.config/master/openshift-registry.kubeconfig

oadm registry 
# start router
oadm policy add-scc-to-user hostnetwork -z router
oadm router
