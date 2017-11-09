```
export KUBECONFIG=~/.kube/config
make
make build-extended-test
FOCUS='templateservicebroker end-to-end test' TEST_ONLY=1 SKIP_TEARDOWN=1 DELETE_NAMESPACE=false \
PARALLEL_NODES=1 test/extended/core.sh
```
