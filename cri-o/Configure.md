### Build & Iinstall runc
```
git clone https://github.com/opencontainers/runc
cd runc
make && make install
```

### Build & Install crio
```
git clone https://github.com/kubernetes-incubator/cri-o.git
cd cri-o
make BUILDTAGS='seccomp'
make install install.config install.completions install.systemd
```

#### Configure crio after install
```
1) update `runc` path to "/usr/local/sbin/runc" in /etc/crio/crio.conf
2) as "signature_policy" in /etc/crio/crio.conf is empty, it will read /etc/containers/policy.json
mkdir /etc/containers
cp -p test/policy.json /etc/containers/policy.json
```

### Configure cni
```
go get -d github.com/containernetworking/plugins
cd $GOPATH/src/github.com/containernetworking/plugins
./build.sh
```

#### install cni
```
sudo mkdir -p /opt/cni/bin
sudo cp bin/* /opt/cni/bin/
```
#### config cni
```
sudo mkdir -p /etc/cni/net.d
sh -c 'cat >/etc/cni/net.d/10-mynet.conf <<-EOF
{
    "cniVersion": "0.2.0",
    "name": "mynet",
    "type": "bridge",
    "bridge": "cni0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "subnet": "10.88.0.0/16",
        "routes": [
            { "dst": "0.0.0.0/0"  }
        ]
    }
}
EOF'

sudo sh -c 'cat >/etc/cni/net.d/99-loopback.conf <<-EOF
{
    "cniVersion": "0.2.0",
    "type": "loopback"
}
EOF'
```

### Start k8s
```
CONTAINER_RUNTIME=remote \
CONTAINER_RUNTIME_ENDPOINT='/var/run/crio.sock  --runtime-request-timeout=15m' \
./hack/local-up-cluster.sh
```

### Use [crictl](https://github.com/kubernetes-incubator/cri-tools/tree/master/cmd/crictl) as client command for cri-o
```
export CRI_RUNTIME_ENDPOINT=/var/run/crio.sock
export CRI_IMAGE_ENDPOINT=/var/run/crio.sock
crictl ps
```
### Issue to debug
1. Clean data, 
If you want clean all the container left by last time, you can just delete "storage_root" `/var/lib/containers/storage`
