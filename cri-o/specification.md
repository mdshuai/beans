### kubernetes cri api 

https://github.com/kubernetes/community/blob/master/contributors/devel/container-runtime-interface.md

https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.proto#L1

(note: To regenerate api.pb.go run hack/update-generated-runtime.sh)

`PodSandboxConfig`: https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.pb.go#L671

`ContainerConfig` : https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.pb.go#L1618


### runtime-spec

https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration

`config definition` : https://github.com/opencontainers/runtime-spec/blob/master/specs-go/config.go
