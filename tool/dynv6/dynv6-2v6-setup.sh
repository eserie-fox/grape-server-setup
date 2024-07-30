#!/bin/sh

token=$1
hostname=$2
hostname2=$3

if [ -z "$token" -o -z "$hostname" -o -z "$hostname2" ]; then
  echo "Usage: $0 token hostname hostname2"
  exit 1
fi


mkdir -p /root/dynv6script
rm /root/.dynv6.addr6
cp ./dynv6-2v6only-update.sh /root/dynv6script/
(crontab -l 2>/dev/null; echo "*/2 * * * * token=$token /root/dynv6script/dynv6-2v6only-update.sh $hostname $hostname2") | crontab -

