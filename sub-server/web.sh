#!/bin/sh

dynv6token=$1
dynv6hostname=$2
dynv6hostname2=$3
admin_email=$4
web_hostname=$5
git_server_addr=$6
webdav_server_addr=$7
webdav_users=("${@:8}")

if [ -z "$dynv6token" -o -z "$dynv6hostname" -o -z "$dynv6hostname2" -o -z "$admin_email" -o -z "$web_hostname" -o -z "$git_server_addr" -o -z "$webdav_server_addr" -o "${#webdav_users[@]}" -eq 0 ]; then
  echo "Usage: $0 dynv6token dynv6hostname dynv6hostname2 admin_email web_hostname git_server_addr webdav_server_addr webdav_user1 [webdav_user2 [webdav_user3 ...]]"
  exit 1
fi

cd ../tool

cd ./env
sh ./env-setup.sh
cd ..

cd ./dynv6
sh ./dynv6-2v6-setup.sh $dynv6token $dynv6hostname $dynv6hostname2
cd ..

cd ./web-proxy
sh ./web-proxy-setup.sh $admin_email $web_hostname $git_server_addr $webdav_server_addr ${users[@]}
cd ..


cd ../sub-server
