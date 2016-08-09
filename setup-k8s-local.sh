#/bin/bash 
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/kubernetes/_output/bin/

#deploy local k8s with kube-dns
cd ~/
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes
export KUBERNETES_PROVIDER=local
export KUBE_ENABLE_CLUSTER_DNS=true
export KUBELET_HOST=172.18.12.44 #nodeip
export API_HOST=172.17.0.1  #API_HOST=<ip of docker0>
export HOSTNAME_OVERRIDE=172.18.12.44 #nodeip

hack/local-up-cluster.sh
