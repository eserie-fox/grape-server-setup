#!/bin/sh


mkdir -p /root/frp/current_state
version=$(sh ./download_latest_frp.sh)
cp ./$version/frps /root/frp/frps

echo $version > /root/frp/current_state/frps_version

rm -rf $version
