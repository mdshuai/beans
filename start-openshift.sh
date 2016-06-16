#!/bin/bash
# start openshift all-in-one env
# supose openshift command already in the path
# usage:
# $ sh start-openshift.sh $master_public_ip

public_master=$1
echo $public_master
if [ -d "logs" ]; then
    rm -rf logs
fi
mkdir logs
openshift start --write-config=openshift.local.config --public-master=https://${public_master}:8443
nodeConfig=$(ls openshift.local.config |grep node)
openshift start master --config=openshift.local.config/master/master-config.yaml --loglevel=5 &> logs/openshift-master.log &
openshift start node --config=openshift.local.config/${nodeConfig}/node-config.yaml --loglevel=5 &> logs/openshift-node.log &

export KUBECONFIG=`pwd`/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=`pwd`/openshift.local.config/master/ca.crt
sudo chmod a+rwX "$KUBECONFIG"
sleep 10
# start registry and router
oadm registry
oadm policy add-scc-to-user hostnetwork -z router
oadm router

function cleanup(){
  kill `pidof openshift`
  rm -rf logs/
  rm -rf openshift.local.config/
  rm -rf openshift.local.etcd/
  rm -rf openshift.local.volumes/
}

function buildlatest(){
  git clone https://github.com/openshift/origin.git
  cd origin
  hack/build-go.sh
}
