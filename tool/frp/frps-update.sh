#!/bin/sh

cp /root/frp/frps.service.txt /etc/systemd/system/frps.service

systemctl daemon-reload

systemctl enable frps.service
systemctl restart frps.service
systemctl status frps.service
