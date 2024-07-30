#!/bin/sh

dynv6token=$1
dynv6hostname=$2
web_port=$3
ssh_port=$4

if [ -z "$dynv6token" -o -z "$dynv6hostname" -o -z "$web_port" -o -z "$ssh_port" ]; then
  echo "Usage: $0 dynv6token dynv6hostname web_port ssh_port"
  exit 1
fi

cd ../tool

cd ./env
sh ./env-setup.sh
cd ..

cd ./dynv6
sh ./dynv6-setup.sh $dynv6token $dynv6hostname
cd ..

cd ./gitea
sh ./gitea-setup.sh $web_port $ssh_port
cd ..

cd ../sub-server
