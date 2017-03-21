## Setup env by kube-up on gce
***masteros:*** [Container-Optimized OS from Google](https://cloud.google.com/compute/docs/containers/vm-image/)

Container-Optimized OS does not include a package manager; as such, you'll be unable install software packages on an instance.

***nodes os:*** [Debian GNU](http://www.debian.org/)

***kubelet config file:*** /etc/default/kubelet

***restart kubelet svc:*** service kubelet restart

cat /etc/os-release
