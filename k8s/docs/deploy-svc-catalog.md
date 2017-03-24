## Deploy svc-catalog in k8s

1. deploy k8s cluster with dns

2. install glide
```
go get github.com/Masterminds/glide
```

3. install helm & make sure tiller is running
```
go get k8s.io/helm
helm init
```

4. deploy svc-catalog
```
git clone https://github.com/kubernetes-incubator/service-catalog.git
cd service-catalog
make build
helm install charts/catalog --name catalog --namespace catalog
```

5. install direnv, after install add .envrc svc-catalog dir
```
go get github.com/direnv/direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
cat > .envrc <<EOF
export REGISTRY="hub.docker.io/deshuai"
export KUBECONFIG=/service-catalog/.kubeconfig
EOF
```
