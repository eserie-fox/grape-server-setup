#!/bin/sh

# 使用这个脚本来新建container

docker compose up -d

docker exec -it samba /bin/bash -c "apk -U upgrade && pkill smbd"
