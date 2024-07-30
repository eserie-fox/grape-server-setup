#!/bin/sh

ct_id=$1

if [ -z "$ct_id" ]; then
  echo "Usage: $0 ct_id"
  exit 1
fi

echo 'lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir' >> /etc/pve/lxc/${ct_id}.conf
