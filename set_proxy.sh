#!/bin/bash
# run this script in current shell example: 
# "source set_proxy.sh example.proxy.com:3200" or ". set_proxy.sh example.proxy.com:3200"

function set_proxy(){
  typeset -u NAME
  for name in http ftp https all
  do
    NAME=$name
    if [ "$name" == "all" ]
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
}

proxy_url=$1
if [ ! "$proxy_url" ];then
  echo "must set proxy"
else
  set_proxy
  # output the proxy env after set.
  env|grep -i proxy
fi
