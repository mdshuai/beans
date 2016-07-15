#!/bin/bash

yum install -y ansible git python-netaddr
git clone https://github.com/kubernetes/contrib.git
cd contrib/ansible

eval `ssh-agent -s`
ssh-add ~/libra-new.pem

cat << EOF > inventory
[masters]
kube-master.example.com
[etcd]
kube-master.example.com
[nodes]
kube-node-01.example.com

EOF
#if you want use other k8s version, you can change 'kube_version'
# https://github.com/kubernetes/contrib/blob/master/ansible/roles/kubernetes/defaults/main.yml#L2
./setup.sh
