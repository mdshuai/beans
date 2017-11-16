### kubernetes cri api 

https://github.com/kubernetes/community/blob/master/contributors/devel/container-runtime-interface.md

https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.proto#L1

(note: To regenerate api.pb.go run hack/update-generated-runtime.sh)

`PodSandboxConfig`: https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.pb.go#L671

`ContainerConfig` : https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/apis/cri/v1alpha1/runtime/api.pb.go#L1618


### runtime-spec

https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration

`config definition` : https://github.com/opencontainers/runtime-spec/blob/master/specs-go/config.go


### Proposal: Kubelet OCI runtime integration (cri-o)

https://github.com/kubernetes/kubernetes/pull/26788



[cri-o.io](http://cri-o.io/)

The architectural components are as follows:
```
    Kubernetes contacts the kubelet to launch a pod.
        Pods are a kubernetes concept consisting of one or more containers sharing the same IPC, NET and PID namespaces and living in the same cgroup.
    The kublet forwards the request to the CRI-O daemon VIA kubernetes CRI (Container runtime interface) to launch the new POD.
    CRI-O uses the containers/image library to pull the image from a container registry.
    The downloaded image is unpacked into the container’s root filesystems, stored in COW file systems, using containers/storage library.
    After the rootfs has been created for the container, CRI-O generates an OCI runtime specification json file describing how to run the container using the OCI Generate tools.
    CRI-O then launches an OCI Compatible Runtime using the specification to run the container proceses. The default OCI Runtime is runc.
    Each container is monitored by a separate conmon process. The conmon process holds the pty of the PID1 of the container process. It handles logging for the container and records the exit code for the container process.
    Networking for the pod is setup through use of CNI, so any CNI plugin can be used with CRI-O.
```
