###Get metrics from haepster in OpenShift
* Get metrics from [apis/metrics](https://github.com/kubernetes/heapster/blob/master/metrics/apis/metrics/handlers.go#L54-L92)

#### /apis/metrics/v1alpha1/namespaces/{ns}/pods/?labelSelector="{label}"
```
oadm policy add-cluster-role-to-user cluster-admin $user
token=`oc whoami -t`
token=rvSA594JdSeRx0ZCMMonqCQIg7J-Bc1DhGE9E70Elb0

[root@qe-dma1-master-1 ~]# curl -k -H "Authorization: Bearer $token" -X GET https://qe-dma1-master-1.0210-tte.qe.rhcloud.com:8443/api/v1/proxy/namespaces/openshift-infra/services/https:heapster:/apis/metrics/v1alpha1/namespaces/dma1/pods/
{
  "metadata": {},
  "items": [
   {
    "metadata": {
     "name": "hello-pod",
     "namespace": "dma1",
     "creationTimestamp": "2017-02-10T07:40:47Z"
    },
    "timestamp": "2017-02-10T07:40:30Z",
    "window": "1m0s",
    "containers": [
     {
      "name": "hello-pod",
      "usage": {
       "cpu": "0",
       "memory": "936Ki"
      }
     }
    ]
   },
   {
    "metadata": {
     "name": "resource-consumer-1-3b8dw",
     "namespace": "dma1",
     "creationTimestamp": "2017-02-10T07:40:47Z"
    },
    "timestamp": "2017-02-10T07:40:30Z",
    "window": "1m0s",
    "containers": [
     {
      "name": "resource-consumer",
      "usage": {
       "cpu": "0",
       "memory": "1788Ki"
      }
     }
    ]
   }
  ]
 }
 //Get selector pods metrics
$ curl -k -H "Authorization: Bearer $token" -X GET https://qe-dma1-master-1.0210-tte.qe.rhcloud.com:8443/api/v1/proxy/namespaces/openshift-infra/services/https:heapster:/apis/metrics/v1alpha1/namespaces/dma1/pods/?labelSelector="name=hello-pod"
{
  "metadata": {},
  "items": [
   {
    "metadata": {
     "name": "hello-pod",
     "namespace": "dma1",
     "creationTimestamp": "2017-02-10T07:40:49Z"
    },
    "timestamp": "2017-02-10T07:40:30Z",
    "window": "1m0s",
    "containers": [
     {
      "name": "hello-pod",
      "usage": {
       "cpu": "0",
       "memory": "936Ki"
      }
     }
    ]
   }
  ]
 }[root@qe-dma1-master-1 ~]# 

```

* Get metrics from [/api/v1/model](https://github.com/kubernetes/heapster/blob/master/docs/model.md#api-documentation)

#### /api/v1/model/namespaces/{ns}/pods/{pod}/metrics/{metrics}
```
oadm policy add-cluster-role-to-user cluster-admin $user
token=`oc whoami -t`
token=rvSA594JdSeRx0ZCMMonqCQIg7J-Bc1DhGE9E70Elb0
//Get pod list
curl -k -H "Authorization: Bearer $token" -X GET https://qe-dma1-master-1.0210-tte.qe.rhcloud.com:8443/api/v1/proxy/namespaces/openshift-infra/services/https:heapster:/api/v1/model/namespaces/dma1/pods/
//Get metrics list
curl -k -H "Authorization: Bearer $token" -X GET https://qe-dma1-master-1.0210-tte.qe.rhcloud.com:8443/api/v1/proxy/namespaces/openshift-infra/services/https:heapster:/api/v1/model/namespaces/dma1/pods/resource-consumer-1-3b8dw/metrics/
//Get cpu metrics
curl -k -H "Authorization: Bearer $token" -X GET  https://qe-dma1-master-1.0210-tte.qe.rhcloud.com:8443/api/v1/proxy/namespaces/openshift-infra/services/https:heapster:/api/v1/model/namespaces/dma1/pods/resource-consumer-1-3b8dw/metrics/cpu/usage_rate
```

#### Get node stats from apiserver api
```
oc get --raw api/v1/nodes/<nodename>/proxy/stats/summary
```
