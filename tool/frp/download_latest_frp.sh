#!/bin/sh

# 获取最新下载链接
url=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4)

curl -O $url
filename=$( ls | grep -E '^frp.*linux_amd64\.tar\.gz$' | tail -n 1)
version=$(basename "$filename" .tar.gz)

tar -xzf $filename

#清除
rm frp*linux_amd64.tar.gz

echo $version