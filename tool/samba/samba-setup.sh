#!/bin/sh


docker_compose_file=$1

if [ -z "$docker_compose_file" ]; then
  echo "Usage: $0 docker_compose_file"
  exit 1
fi

if [ ! -f "$docker_compose_file" ]; then
    echo "Error: $docker_compose_file does not exist."
    exit 1
fi

uid=$(id -u www-data)
gid=$(id -g www-data)

mkdir -p /root/samba

cp $docker_compose_file /root/samba/docker-compose.yml
sed -i 's/\(USERID:\s*\)33/\1'"${uid}"'/' /root/samba/docker-compose.yml
sed -i 's/\(GROUPID:\s*\)33/\1'"${gid}"'/' /root/samba/docker-compose.yml

cp ./samba-docker-up.sh /root/samba/
chmod +x /root/samba/samba-docker-up.sh 

