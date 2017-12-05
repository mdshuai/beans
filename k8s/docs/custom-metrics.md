```
export ALLOW_SECURITY_CONTEXT=true
export HOSTNAME_OVERRIDE=ip-172-18-13-114.ec2.internal
export KUBELET_HOST=ip-172-18-13-114.ec2.internal

//Setting HOSTNAME_OVERRIDE=xxxx to match the name seen by your cloud provider should result in a correct credential for your kubelet

1. Set configure 
# configure in kube-apiserver
# --runtime-config=api/all=true
--runtime-config=autoscaling/v2beta1=true

# configure in kube-controller-manager
--horizontal-pod-autoscaler-use-rest-clients=true
--horizontal-pod-autoscaler-sync-period=10s
--allow-untagged-cloud=true

kubectl api-versions
https://github.com/luxas/kubeadm-workshop/blob/master/images/autoscaling/server.js




--authorization-mode=Node,RBAC


templateNamespaces

//deploy prometheus(by statefulset)
kubectl create -f prometheus-operator.yaml 
kubectl create -f sample-prometheus-instance.yaml

statefulset



//Deploy a custom API server
[root@dma monitoring]# kubectl create -f custom-metrics.yaml 
namespace "custom-metrics" created
serviceaccount "custom-metrics-apiserver" created
clusterrolebinding "custom-metrics:system:auth-delegator" created
rolebinding "custom-metrics-auth-reader" created
clusterrole "custom-metrics-resource-reader" created
clusterrolebinding "custom-metrics-apiserver-resource-reader" created
clusterrole "custom-metrics-getter" created
clusterrolebinding "hpa-custom-metrics-getter" created
deployment "custom-metrics-apiserver" created
service "api" created
apiservice "v1beta1.custom.metrics.k8s.io" created
clusterrole "custom-metrics-server-resources" created
clusterrolebinding "hpa-controller-custom-metrics" created

kubectl api-versions | grep custom.metrics

kubectl get hpa.v2beta1.autoscaling
kubectl describe hpa.v2beta1.autoscaling sample-metrics-app-hpa






//--------------------------------------------------------------------------------------------------------------------------------

#### Prepare env


#!/bin/bash
export ALLOW_SECURITY_CONTEXT=true
#Setting HOSTNAME_OVERRIDE=xxxx to match the name seen by your cloud provider should result in a correct credential for your kubelet
export HOSTNAME_OVERRIDE=ip-172-18-13-114.ec2.internal
export KUBELET_HOST=172.18.13.114

export CLOUD_PROVIDER=aws
export CLOUD_CONFIG=/etc/aws/aws.conf
export AWS_ACCESS_KEY_ID=AKIAJSXLL3JLW4R66DLQ
export AWS_SECRET_ACCESS_KEY=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


1. Set configure
# configure in kube-apiserver
# --runtime-config=api/all=true
--runtime-config=autoscaling/v2beta1=true

# configure in kube-controller-manager
--horizontal-pod-autoscaler-use-rest-clients=true
--horizontal-pod-autoscaler-sync-period=10s
--allow-untagged-cloud=true



#### For custom metrics, deploy k8s-prometheus-adapter

//hpa v2beta1
kubectl get hpa.v2beta1.autoscaling


curl -k https://${apiserver}:443/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/sample-metrics-app/http_requests
kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/sample-metrics-app/http_requests
kubectl get hpa.v2beta1.autoscaling sample-metrics-app-hpa -o yaml





#### For reouce metrics, we need metrics-server

https://github.com/kubernetes-incubator/metrics-server
//metrics-server
kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods | python -m json.tool
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | python -m json.tool
kubectl get --raw /apis/metrics.k8s.io/v1beta1/namespaces/dma/pods/hello-pod | python -m json.tool
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/ip-172-18-13-114.ec2.internal | python -m json.tool

//metrics-server collects metrics from the Summary API, exposed by Kubelet on each node.
curl -k -H "Authorization: Bearer MDGLbStCHbpAKK4v4a6trpn-uU9D_rJ9Yfj9rLGjCNM" -X GET https://${node-ip}:10250/stats/summary





#### Issue for debug
1. error
I1129 11:07:59.227411    5757 event.go:218] Event(v1.ObjectReference{Kind:"ReplicaSet", Namespace:"custom-metrics", Name:"custom-metrics-apiserver-7fdd9f89b4", UID:"502e03da-d4b2-11e7-b623-68f7281d8004", APIVersion:"extensions", ResourceVersion:"977", FieldPath:""}): type: 'Warning' reason: 'FailedCreate' Error creating: pods "custom-metrics-apiserver-7fdd9f89b4-dnr7h" is forbidden: SecurityContext.RunAsUser is forbidden
E1129 11:07:59.227468    5757 replica_set.go:451] Sync "custom-metrics/custom-metrics-apiserver-7fdd9f89b4" failed with pods "custom-metrics-apiserver-7fdd9f89b4-dnr7h" is forbidden: SecurityContext.RunAsUser is forbidden

//export ALLOW_SECURITY_CONTEXT=true


2.   Warning  FailedMount  7s (x5 over 14s)  kubelet, ip-172-18-13-114.ec2.internal  MountVolume.SetUp failed for volume "prometheus-operator-token-g2tcx" : secrets "prometheus-operator-token-g2tcx" is forbidden: User "system:node:127.0.0.1" cannot get secrets in the namespace "default": no path found to object

//export HOSTNAME_OVERRIDE=ip-172-18-13-114.ec2.internal


3.   storageClassName: rook-block (used by prometheus)

kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: rook-block
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zone: us-east-1d

4. Error from server: Get https://ip-172-18-13-114.ec2.internal:10250/containerLogs/custom-metrics/custom-metrics-apiserver-7fdd9f89b4-dn54c/custom-metrics-server: dial tcp 172.18.13.114:10250: getsockopt: connection refused
//export KUBELET_HOST=172.18.13.114


5. 
/apis/custom.metrics.k8s.io/v1beta1
kubectl create clusterrolebinding custom-metrics --clusterrole=cluster-admin --user=system:anonymous


6.     message: 'the HPA controller was unable to get the target''s current scale: no
      matches for /, Kind=Deployment
//Need set apiversion for "deployment" in hpa.spec.scaleTargetRef



//--------------------------------------------------------------------------------------------------------------------------------
metrics-server

kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/ | python -m json.tool


1. Will metrics-server release with ocp 3.8 or 3.9?
2. If use hpa v2beta1(resources, pod, object ) we must set --horizontal-pod-autoscaler-use-rest-clients=true, right?
--horizontal-pod-autoscaler-use-rest-clients default true?






summary: 
1. heapster not support hpa v2beta1, will metrics-server release with ocp3.8 or 3.9?
2. For hpa v2beta1 feature, we need use metrics-server(for ResourceMetricSource ) & k8s-prometheus-adapter (for ObjectMetricSource, PodsMetricSource) + prometheus
3. "--horizontal-pod-autoscaler-use-rest-clients" now default is true, it use api metrics.k8s.io/v1beta1 & custom.metrics.io/v1beta1
4. compatibility: hpav1 can work in both below case
--horizontal-pod-autoscaler-use-rest-clients=true + metrics-server
--horizontal-pod-autoscaler-use-rest-clients=false + heapster

//hpav2alpha1 (xxx, 3.7)?
--horizontal-pod-autoscaler-use-rest-clients=true + heapster(--apisever)

5. what's metrics can podsmetricsource export cpu/memory?
6. 80 80m



//deploy prometheus
kubectl create clusterrolebinding prometheus --clusterrole=cluster-admin --user=system:serviceaccount:default:prometheus

//--------------------------------------------------------------------------------------------------------------------------------
kubectl get --raw /apis/metrics.k8s.io/              | python -m json.tool
kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods  | python -m json.tool
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | python -m json.tool
kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | python -m json.tool
ubectl get --raw /apis/custom.metrics.k8s.io/v1beta1/namespaces/default/metrics/up   (retrieve the given metric which describes the given namespace.)

[root@ip-172-18-13-114 monitoring]# kubectl get --raw /apis/metrics.k8s.io/v1beta1 | python -m json.tool
{
    "apiVersion": "v1",
    "groupVersion": "metrics.k8s.io/v1beta1",
    "kind": "APIResourceList",
    "resources": [
        {
            "kind": "NodeMetrics",
            "name": "nodes",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get",
                "list"
            ]
        },
        {
            "kind": "PodMetrics",
            "name": "pods",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get",
                "list"
            ]
        }
    ]
}
[root@ip-172-18-13-114 monitoring]# kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | python -m json.tool
{
    "apiVersion": "v1",
    "groupVersion": "custom.metrics.k8s.io/v1beta1",
    "kind": "APIResourceList",
    "resources": [
        {
            "kind": "MetricValueList",
            "name": "namespaces/scrape_samples_scraped",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "services/scrape_samples_scraped",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "jobs.batch/up",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "pods/up",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "jobs.batch/scrape_samples_post_metric_relabeling",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "jobs.batch/http_requests",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "services/scrape_samples_post_metric_relabeling",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "namespaces/up",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "services/http_requests",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "jobs.batch/scrape_duration_seconds",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "services/scrape_duration_seconds",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "namespaces/scrape_samples_post_metric_relabeling",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "pods/scrape_samples_post_metric_relabeling",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "jobs.batch/scrape_samples_scraped",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "pods/http_requests",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "namespaces/scrape_duration_seconds",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "pods/scrape_duration_seconds",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "pods/scrape_samples_scraped",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "services/up",
            "namespaced": true,
            "singularName": "",
            "verbs": [
                "get"
            ]
        },
        {
            "kind": "MetricValueList",
            "name": "namespaces/http_requests",
            "namespaced": false,
            "singularName": "",
            "verbs": [
                "get"
            ]
        }
    ]
}
[root@ip-172-18-13-114 monitoring]# kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/sample-metrics-app/scrape_duration_seconds | python -m json.tool
{
    "apiVersion": "custom.metrics.k8s.io/v1beta1",
    "items": [
        {
            "describedObject": {
                "apiVersion": "/__internal",
                "kind": "Service",
                "name": "sample-metrics-app"
            },
            "metricName": "scrape_duration_seconds",
            "timestamp": "2017-12-05T09:26:14Z",
            "value": "0"
        }
    ],
    "kind": "MetricValueList",
    "metadata": {
        "selfLink": "/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/sample-metrics-app/scrape_duration_seconds"
    }
}









```
