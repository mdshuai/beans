#/bin/bash
yum remove golang
wget https://storage.googleapis.com/golang/go1.6.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.6.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
go get -u github.com/jteeuwen/go-bindata/go-bindata
git clone https://github.com/kubernetes/kubernetes.git
ca kubernetes/
make
