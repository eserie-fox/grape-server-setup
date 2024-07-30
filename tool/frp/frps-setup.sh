#!/bin/sh

config_file=$1

if [ -z "$config_file" ]; then
  echo "Usage: $0 path/to/frps.toml"
  exit 1
fi


mkdir -p /root/frp
mkdir -p /root/frp/logs
cp $config_file /root/frp/frps.toml
cp ./frps-update.sh /root/frp/
cp ./frps.service.txt /root/frp/

mkdir -p /root/frp/current_state
ln -s /usr/lib/systemd/system/frps.service /root/frp/current_state/frps.service
ln -s /root/frp/frps.toml /root/frp/current_state/frps.toml
sh ./upgrade_frps.sh

chmod +x /root/frp/frps-update.sh
