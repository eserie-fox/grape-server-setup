#!/bin/sh


mkdir -p /root/frp/current_state
version=$(sh ./download_latest_frp.sh)
cp ./$version/frpc /root/frp/frpc

echo $version > /root/frp/current_state/frpc_version

rm -rf $version
