#!/bin/bash

REGISTRY="docker.io/deshuai/"
APISERVER_IMAGE=docker.io/deshuai/apiserver:canary
CONTROLLER_IMAGE=docker.io/deshuai/controller-manager:canary
UPSBROKER_IMAGE=docker.io/deshuai/user-broker:canary

deploy_svc_catalog () {
  helm install charts/catalog --name catalog --set apiserver.image=${APISERVER_IMAGE},controllerManager.image=${CONTROLLER_IMAGE} --namespace catalog
  helm install charts/ups-broker --name ups-broker --set image=${UPSBROKER_IMAGE} --namespace ups-broker
}

kc_comamnd (){
  APISERVER=`kubectl get svc/catalog-catalog-apiserver -o template --template "{{.spec.clusterIP}}" -n catalog`
  kubectl config set-cluster service-catalog --server=http://${APISERVER}:80
  kubectl config set-context service-catalog --cluster=service-catalog
  alias kc='kubectl --context=service-catalog'
}

build_latest_image() {
  git clone https://github.com/kubernetes-incubator/service-catalog.git
  cd service-catalog
  make build
  #The target images registry is set by ${REGISTRY}
  make images
  make push
  cd .. && rm -rf service-catalog
}

deploy_svc_catalog
kc_comamnd
