#!/bin/sh

ovpn_ipv4_hostname=$1
ovpn_ipv6_hostname=$2
ovpn_port=$3

if [ -z "$ovpn_ipv4_hostname" -o -z "$ovpn_ipv6_hostname" -o -z "$ovpn_port" ]; then
  echo "Usage: $0 ovpn_ipv4_hostname ovpn_ipv6_hostname ovpn_port"
  exit 1
fi


export AUTO_INSTALL=y
export APPROVE_INSTALL=y
export APPROVE_IP=y
export ENDPOINT=$ovpn_ipv4_hostname
export IPV6_SUPPORT=y
export PORT_CHOICE=2
export PORT=$ovpn_port
export PROTOCOL_CHOICE=1
export DNS=1
export COMPRESSION_ENABLED=n
export CUSTOMIZE_ENC=n
export CLIENT=fox
export PASS=1

/root/openvpn/openvpn-install.sh

mv /root/fox.ovpn /root/openvpn/fox.ovpn
cp /root/openvpn/fox.ovpn /root/openvpn/foxv6.ovpn

sed -i "s/^remote \([^ ]*\) \([^ ]*\)$/remote $ovpn_ipv6_hostname \2/" /root/openvpn/foxv6.ovpn
