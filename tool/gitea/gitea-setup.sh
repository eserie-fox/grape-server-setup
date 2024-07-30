#!/bin/sh


web_port=$1
ssh_port=$2

if [ -z "$web_port" -o -z "$ssh_port" ]; then
  echo "Usage: $0 web_port ssh_port"
  exit 1
fi

# 新建用户 git
useradd -M git

git_uid=$(id -u git)
git_gid=$(id -g git)

mkdir -p /root/gitea
cp ./docker-compose.yml /root/gitea/docker-compose.yml
sed -i 's/USER_UID=1000/USER_UID='"$git_uid"'/g' /root/gitea/docker-compose.yml
sed -i 's/USER_GID=1000/USER_GID='"$git_gid"'/g' /root/gitea/docker-compose.yml
sed -i 's/3001:3000/'"$web_port"':3000/g' /root/gitea/docker-compose.yml
sed -i 's/39184:22/'"$ssh_port"':22/g' /root/gitea/docker-compose.yml

