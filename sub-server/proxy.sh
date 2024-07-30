#!/bin/sh

dynv6token=$1
dynv6hostname=$2

if [ -z "$dynv6token" -o -z "$dynv6hostname" ]; then
  echo "Usage: $0 dynv6token dynv6hostname"
  exit 1
fi

cd ../tool

cd ./env
sh ./env-setup.sh
cd ..

cd ./dynv6
sh ./dynv6-setup.sh $dynv6token $dynv6hostname
cd ..

cd ./shellcrash
sh ./shellcrash-setup.sh
cd ..


cd ../sub-server
