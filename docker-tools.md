#####1. Get all image tags
```
curl -k https://index.docker.io/v1/repositories/deshuai/ruby-20-centos7/tags | python -mjson.tool
```
#####2. Docker images related command
```
docker rmi $(docker images -q)
docker images --filter "dangling=true"
docker images -q
```
#####3. Get inodes summay
```
df -i|awk 'NR>1 {print $3}'|awk '{sum+=$1} END {print "sum =", sum}'
```
