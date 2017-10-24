[system-container usage](https://github.com/projectatomic/atomic-system-containers/blob/master/USAGE.md)

```
//example, install&run a systemd service (using runc)
atomic pull --storage ostree ${registry}/openshift3/ose:v3.7.0-0.176.0
atomic install --system --name=atomic-openshift-master-api ${registry}/openshift3/ose:v3.7.0-0.176.0
```
