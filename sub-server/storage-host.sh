#!/bin/sh

ct_id=$1

if [ -z "$ct_id" ]; then
  echo "Usage: $0 ct_id"
  exit 1
fi

# 将host下的HDD1T2.5inchUSB通给ct_id的DiskBackup1T
pct set $ct_id -mp0 /mnt/HDD1T2.5inchUSB/,mp=/mnt/DiskBackup1T
# 同理
pct set $ct_id -mp1 /mnt/HDD3T3.5inchSATA/,mp=/mnt/DiskMain3T

#将所有者设置为容器的root。在pve中有一个偏移量定义，默认为100000:100000
chown -R 100000:100000 /mnt/HDD1T2.5inchUSB/
chown -R 100000:100000 /mnt/HDD3T3.5inchSATA/

