#!/bin/sh

cp /root/frp/frpc.service.txt /etc/systemd/system/frpc.service

systemctl daemon-reload

systemctl enable frpc.service
systemctl restart frpc.service
systemctl status frpc.service
