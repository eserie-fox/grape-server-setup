#!/bin/sh


ovpn_ipv4_hostname=$1
ovpn_ipv6_hostname=$2
ovpn_port=$3

if [ -z "$ovpn_ipv4_hostname" -o -z "$ovpn_ipv6_hostname" -o -z "$ovpn_port" ]; then
  echo "Usage: $0 ovpn_ipv4_hostname ovpn_ipv6_hostname ovpn_port"
  exit 1
fi


mkdir -p /root/openvpn

cd /root/openvpn
curl -o /root/openvpn/openvpn-install.sh https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x /root/openvpn/openvpn-install.sh

sh ./headless-openvpn-install.sh $ovpn_ipv4_hostname $ovpn_ipv6_hostname $ovpn_port
