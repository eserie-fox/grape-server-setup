#!/bin/sh


ovpn_ipv4_hostname=$1
ovpn_ipv6_hostname=$2
ovpn_port=$3

if [ -z "$ovpn_ipv4_hostname" -o -z "$ovpn_ipv6_hostname" -o -z "$ovpn_port" ]; then
  echo "Usage: $0 ovpn_ipv4_hostname ovpn_ipv6_hostname ovpn_port"
  exit 1
fi


mkdir -p /root/openvpn

curl -o /root/openvpn/openvpn-install.sh https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x /root/openvpn/openvpn-install.sh

sh ./headless-openvpn-install.sh $ovpn_ipv4_hostname $ovpn_ipv6_hostname $ovpn_port

# 允许客户端相互看见
echo "client-to-client" >> /etc/openvpn/server.conf

# 允许客户端用一个配置文件连多个（方便）
echo "duplicate-cn" >> /etc/openvpn/server.conf

# 重启
systemctl restart openvpn@server
systemctl restart openvpn
