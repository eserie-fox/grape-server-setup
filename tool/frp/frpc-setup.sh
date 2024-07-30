#!/bin/sh

config_file=$1

if [ -z "$config_file" ]; then
  echo "Usage: $0 path/to/frpc.toml"
  exit 1
fi


mkdir -p /root/frp
mkdir -p /root/frp/logs
cp $config_file /root/frp/frpc.toml
cp ./frpc-update.sh /root/frp/
cp ./frpc.service.txt /root/frp/

mkdir -p /root/frp/current_state
ln -s /usr/lib/systemd/system/frpc.service /root/frp/current_state/frpc.service
ln -s /root/frp/frpc.toml /root/frp/current_state/frpc.toml
sh ./upgrade_frpc.sh

chmod +x /root/frp/frpc-update.sh
