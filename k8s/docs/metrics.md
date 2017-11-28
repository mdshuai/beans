```
https://github.com/kubernetes/metrics (metrics-related API types and clients )
//1. custom metrics api (arbitrary metrics which describe Kubernetes resources)
import k8s.io/metrics/pkg/apis/custom_metrics
https://github.com/kubernetes-incubator/custom-metrics-apiserver  (library)
//implementation server
https://github.com/directxman12/k8s-prometheus-adapter    (need test)
https://github.com/GoogleCloudPlatform/k8s-stackdriver


//2. resource metrics api  (cpu and memory)
import k8s.io/metrics/pkg/apis/metrics
//implementation server
https://github.com/kubernetes/heapster
https://github.com/kubernetes-incubator/metrics-server   (import need R&D)




//3. core metrics pipeline starting from k8s 1.8
https://kubernetes.io/docs/tasks/debug-application-cluster/core-metrics-pipeline/

//resource metrics
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/instrumentation/monitoring_architecture.md
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/instrumentation/resource-metrics-api.md
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/instrumentation/metrics-server.md
```
