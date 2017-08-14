1. Build runc
```
cd github.com/opencontainers
git clone https://github.com/opencontainers/runc
cd runc
make
make install
```

2. In order to use runc you must have your container in the format of an OCI bundle.
```
mkdir hello-pod
cd hello-pod
mkdir rootfs
//export busybox via Docker into the rootfs directory
docker export $(docker create docker.io/ocpqe/hello-pod) | tar -C rootfs -xvf -
```

3. Generate a spec in the format of a config.json
runc spec

4. Running Containers
1) run directly
```
runc run hello-pod
```
2) set "terminal": false  => config.json; args: hello-pod => config.json;
```
runc create hello-pod
runc list
runc start hello-pod
runc kill hello-pod
runc delete hello-pod
```
