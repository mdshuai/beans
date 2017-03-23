## Setup env by kube-up on gce
#### Master instance
***masteros:*** [Container-Optimized OS from Google](https://cloud.google.com/compute/docs/containers/vm-image/)

Container-Optimized OS does not include a package manager; as such, you'll be unable install software packages on an instance.

***config file*** ```/etc/kubernetes/manifests/kube-controller-manager.manifest``` change this file will cause restart svc

***log file*** ```/var/log/kube-controller-manager.log```

#### Node instances

***nodes os:*** [Debian GNU](http://www.debian.org/)

***kubelet config file:*** /etc/default/kubelet

***restart kubelet svc:*** service kubelet restart

***disable kubelet/docker autorestart****
```
# sed -i 's/autorestart\=true/autorestart\=false/g' /etc/supervisor/conf.d/kubelet.conf
# sed -i 's/autorestart\=true/autorestart\=false/g' /etc/supervisor/conf.d/docker.conf
# supervisorctl reload
```
cat /etc/os-release


## Configure aws cloud-provider for k8s
* if you run all-in-one
```
# export CLOUD_PROVIDER=aws
# export CLOUD_CONFIG=/etc/aws/aws.conf
# export AWS_ACCESS_KEY_ID=${key_id}
# export AWS_SECRET_ACCESS_KEY=${access_key}
# cat /etc/aws/aws.conf
[Global]
Zone = us-east-1d
```

* run cluster env
```
--cloud-provider=aws
--cloud-config=/etc/aws/aws.conf
# export AWS_ACCESS_KEY_ID=${key_id}
# export AWS_SECRET_ACCESS_KEY=${access_key}
```
