#!/bin/bash
#Deploy latest k8s on gce by kube-up.sh
#configure gcloud on host & test gcloud works well
gcloud auth login
gcloud config set project $project
gcloud config set compute/zone us-central1-b
#gcloud compute instances create example-instance --machine-type n1-standard-1 --image debian-8
#gcloud compute --project $project ssh --zone "us-central1-a" "dma@example-instance"
#gcloud compute instances delete example-instance

#prepare the release
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes
make quick-release

#deploy k8s cluster on gce
export KUBERNETES_PROVIDER=gce
export KUBE_GCE_INSTANCE_PREFIX=dma-k8s
export NUM_NODES=2
./cluster/kube-up.sh

#When finish test please shutdown the env by
./cluster/kube-down.sh
