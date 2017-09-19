```
#!/bin/bash
#build runc
git clone https://github.com/opencontainers/runc
cd runc
make && make install

#build & install cri-o
git clone https://github.com/kubernetes-incubator/cri-o.git
cd cri-o
make BUILDTAGS='seccomp'
make install install.config install.completions install.systemd
```
