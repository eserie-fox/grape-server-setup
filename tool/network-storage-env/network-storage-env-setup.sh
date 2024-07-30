#!/bin/sh


admin_email=$1

if [ -z "$admin_email" ]; then
  echo "Usage: $0 admin_email"
  exit 1
fi

# 定时备份
(crontab -l 2>/dev/null; echo "30 3 * * * /mnt/DiskMain3T/backup_all.sh") | crontab -

apt -y install apache2
apt -y install apache2-utils 

# 修改管理员邮箱
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-available/000-default.conf
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-enabled/000-default.conf

systemctl restart apache2
