#!/bin/bash
# usage `source set_proxy.sh + your proxy`
# example: source set_proxy.sh example.proxy.com:3200
proxy_url=$1
echo $proxy_url
typeset -u NAME
for name in http ftp https all
do
  NAME=$name
  echo $NAME
  if [ "$name" = "all" ]
  then
    export "$name"_proxy=socks://"$proxy_url"/
    export "$NAME"_PROXY=socks://"$proxy_url"/
  else
    export "$name"_proxy=$name://"$proxy_url"/
    export "$NAME"_PROXY=$name://"$proxy_url"/
  fi
done
export no_proxy=localhost,127.0.0.0/8
export NO_PROXY=localhost,127.0.0.0/8
