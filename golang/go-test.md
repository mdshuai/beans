```
go test -coverprofile fmt
```

```
//example
cd ${GOPATH}/src/github.com/kubernetes-incubator/cri-o/server
go test -tags "seccomp selinux" -v -cover .

```
