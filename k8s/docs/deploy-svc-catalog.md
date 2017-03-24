## Deploy svc-catalog in k8s

* deploy k8s cluster with dns

* install glide
```
go get github.com/Masterminds/glide
```

* install helm & make sure tiller is running
```
go get k8s.io/helm
helm init
```

* deploy svc-catalog
```
git clone https://github.com/kubernetes-incubator/service-catalog.git
cd service-catalog
make build
helm install charts/catalog --name catalog --namespace catalog
```

* install direnv, after install add .envrc svc-catalog dir
```
go get github.com/direnv/direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
cat > .envrc <<EOF
export REGISTRY="hub.docker.io/deshuai"
export KUBECONFIG=/service-catalog/.kubeconfig
EOF
```
