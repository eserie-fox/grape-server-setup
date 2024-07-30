#!/bin/sh

dynv6token=$1
dynv6hostname=$2
ovpn_ipv4_hostname=$3
ovpn_ipv6_hostname=$4
ovpn_port=$5
frpc_config=$6


if [ -z "$dynv6token" -o -z "$dynv6hostname" -o -z "$ovpn_ipv4_hostname" -o -z "$ovpn_ipv6_hostname" -o -z "$ovpn_port" -o -z "$frpc_config" ]; then
  echo "Usage: $0 dynv6token dynv6hostname ovpn_ipv4_hostname ovpn_ipv6_hostname ovpn_port path/to/frpc.toml"
  exit 1
fi

cd ../tool

cd ./env
sh ./env-setup.sh
cd ..

cd ./dynv6
sh ./dynv6-setup.sh $dynv6token $dynv6hostname
cd ..

cd ./frp
sh ./frpc-setup.sh $frpc_config
cd ..

cd ./openvpn
sh ./openvpn-setup.sh $ovpn_ipv4_hostname $ovpn_ipv6_hostname $ovpn_port
cd ..

cd ../sub-server
