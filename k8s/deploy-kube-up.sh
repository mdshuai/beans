#!/bin/bash

#configure gcloud on host & test gcloud works well
gcloud config set project $project
gcloud config set compute/zone us-central1-a
gcloud compute instances create example-instance --machine-type n1-standard-1 --image debian-8
gcloud compute --project $project ssh --zone "us-central1-a" "dma@example-instance"
gcloud compute instances delete example-instance

#prepare the release
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes
make quick-release

#deploy k8s cluster on gce
export KUBERNETES_PROVIDER=gce
export NUM_NODES=2
./cluster/kube-up.sh
