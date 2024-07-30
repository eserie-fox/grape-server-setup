#!/bin/sh


admin_email=$1
web_hostname=$2

if [ -z "$admin_email" -o -z "$web_hostname" ]; then
  echo "Usage: $0 admin_email web_hostname"
  exit 1
fi

# 定时备份
(crontab -l 2>/dev/null; echo "30 3 * * * /mnt/DiskMain3T/backup_all.sh") | crontab -

apt-get -y install apache2
apt-get -y install apache2-utils 

# ServerRoot行后插入ServerName
sed -i "0,/ServerRoot \"[^\"]*\"/s//&\nServerName $web_hostname\n/" /etc/apache2/apache2.conf

# 修改管理员邮箱
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-available/000-default.conf
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-enabled/000-default.conf

systemctl restart apache2
