#!/bin/sh

dynv6token=$1
dynv6hostname=$2
admin_email=$3
web_hostname=$4
samba_docker_compose_file=$5
users=("${@:6}")

if [ -z "$dynv6token" -o -z "$dynv6hostname" -o -z "$admin_email" -o -z "$web_hostname" -o -z "$samba_docker_compose_file" -o "${#users[@]}" -eq 0 ]; then
  echo "Usage: $0 dynv6token dynv6hostname admin_email web_hostname samba_docker_compose_file user1 [user2 [user3 ...]]"
  exit 1
fi

cd ../tool

cd ./env
sh ./env-setup.sh
cd ..

cd ./network-storage-env
sh ./network-storage-env-setup.sh $admin_email
cd ..

cd ./dynv6
sh ./dynv6-setup.sh $dynv6token $dynv6hostname
cd ..

cd ./docker
sh docker-setup.sh
cd ..

cd ./samba
sh ./samba-setup.sh $samba_docker_compose_file
cd ..

cd ./webdav
sh ./webdav-setup.sh ${users[@]}
cd ..


cd ../sub-server
