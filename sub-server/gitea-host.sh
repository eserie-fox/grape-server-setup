#!/bin/sh

ct_id=$1

if [ -z "$ct_id" ]; then
  echo "Usage: $0 ct_id"
  exit 1
fi

# 直通硬盘给git
pct set $ct_id -mp0 /mnt/HDD3T3.5inchSATA/gitea/,mp=/mnt/data

# 将所有权给该容器。在pve中有一个偏移量定义，默认为100000:100000
chown -R 100000:100000 /mnt/HDD3T3.5inchSATA/gitea/
