## Setup env by kube-up on gce
* #### Master instance
***masteros:*** [Container-Optimized OS from Google](https://cloud.google.com/compute/docs/containers/vm-image/)

Container-Optimized OS does not include a package manager; as such, you'll be unable install software packages on an instance.

***config file*** ```/etc/kubernetes/manifests/kube-controller-manager.manifest``` change this file will cause restart svc

***log file*** ```/var/log/kube-controller-manager.log```

* #### Node instances

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

## Configure gce cloud-provider for k8s
* if you run all-in-one
```
# export CLOUD_PROVIDER=gce
# export CLOUD_CONFIG=/etc/gce/gce.conf
# export HOSTNAME_OVERRIDE=${instance_hostname} //eg: preserve-k8s-qe-dma.c.openshift-gce-devel.internal
# cat /etc/gce/gce.conf
[Global]
Zone = us-east-1d
```
* when create loadbalance svc, you met error `Failed to create load balancer for service default/hello-pod: No node tags supplied and also failed to parse the given lists of hosts for tags. Abort creating firewall rule.`
you need add Network tag to your instance
```
#best use instancename as your tag
gcloud compute instances add-tags $instance --tags tag1,tag2
gcloud compute instances remove-tags  $instance --tags tag1,tag2
```
