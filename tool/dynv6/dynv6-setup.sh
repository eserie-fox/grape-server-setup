#!/bin/sh

dynv6token=$1
dynv6hostname=$2

if [ -z "$dynv6token" -o -z "$dynv6hostname" ]; then
  echo "Usage: $0 dynv6token dynv6hostname"
  exit 1
fi


mkdir -p /root/dynv6script
rm /root/.dynv6.addr6
cp ./dynv6-v6only-update.sh /root/dynv6script/
chmod +x /root/dynv6script/dynv6-v6only-update.sh
(crontab -l 2>/dev/null; echo "*/2 * * * * token=$dynv6token /root/dynv6script/dynv6-v6only-update.sh $dynv6hostname") | crontab -
