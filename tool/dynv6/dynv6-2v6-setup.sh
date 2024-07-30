#!/bin/sh

dynv6token=$1
dynv6hostname=$2
dynv6hostname2=$3

if [ -z "$dynv6token" -o -z "$dynv6hostname" -o -z "$dynv6hostname2" ]; then
  echo "Usage: $0 dynv6token dynv6hostname dynv6hostname2"
  exit 1
fi


mkdir -p /root/dynv6script
rm /root/.dynv6.addr6
cp ./dynv6-2v6only-update.sh /root/dynv6script/
chmod +x /root/dynv6script/dynv6-2v6only-update.sh
(crontab -l 2>/dev/null; echo "*/2 * * * * token=$dynv6token /root/dynv6script/dynv6-2v6only-update.sh $dynv6hostname $dynv6hostname2") | crontab -

