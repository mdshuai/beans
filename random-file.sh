#/bin/bash

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000))  
    echo $(($num%$max+$min))  
}  
  
#for i in `seq 1 1 100`; do
for (( ; ; )); do
  rnd=$(rand 100 500)
  dd if=/dev/zero of=test.test bs=1M count=${rnd}
  ls -l test.test -h
  sleep 1
  rm -rf test.test
  sleep 1
done
