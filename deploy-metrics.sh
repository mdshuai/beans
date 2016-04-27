#!/bin/bash

#oc=`which oc`
masterPublicIP=$1
registry=$2
registry="registry.qe.openshift.com"
masterPublicIP="104.154.88.124"
project="openshift-infra"
oc create -f https://raw.githubusercontent.com/openshift/origin-metrics/master/metrics-deployer-setup.yaml -n openshift-infra
oadm policy add-role-to-user edit system:serviceaccount:openshift-infra:metrics-deployer -n openshift-infra
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:openshift-infra:heapster -n openshift-infra
oc secrets new metrics-deployer nothing=/dev/null -n openshift-infra
oc process -f https://raw.githubusercontent.com/openshift/origin-metrics/master/metrics.yaml -v HAWKULAR_METRICS_HOSTNAME=hawkular-metrics.example.com,IMAGE_PREFIX=${registry}/openshift3/,IMAGE_VERSION=latest,USE_PERSISTENT_STORAGE=false,MASTER_URL=https://${masterPublicIP}:8443 | oc create -f - -n ${project}
