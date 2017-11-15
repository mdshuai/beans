### Tmp file for crioctl -> crictl
```
crioctl pod run --config  -> crictl runs          Run a new sandbox
crioctl pod stop --id     -> crictl stops         Stop a running sandbox
crioctl pod remove --id   -> crictl rms           Remove a sandbox
crioctl pod status --id   -> crictl inspects      Display the status of a sandbox
crioctl pod list          -> crictl sandboxes     List sandboxes
                          -> crictl port-forward  Forward local port to a sandbox

crioctl ctr create --config  -> crictl create SANDBOX container-config.[json|yaml] sandbox-config.[json|yaml]
crioctl ctr start --id       -> crictl start
crioctl ctr execsync --id    -> crictl exec -s


//one bug:
[root@dma cri-o]# crictl ps
CONTAINER ID        IMAGE               CREATED             STATE               NAME                ATTEMPT
1c4e650a5cb6b       redis:alpine        21 minutes ago      CONTAINER_RUNNING   podsandbox1-redis   0
[root@dma cri-o]# crictl exec 1c4e650a5cb6b sysctl kernel.msgmax
FATA[0000] execing command in container failed: Internal error occurred: error executing command in container: could not find container "1c4e650a5cb6b"
```
