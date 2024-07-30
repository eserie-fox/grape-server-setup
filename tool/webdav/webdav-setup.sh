#!/bin/sh

digest_passwd="/etc/apache2/.digest_passwd"

if [ ! -f "$digest_passwd" ]; then
    echo "Error: $digest_passwd does not exist. Use 'htdigest /etc/apache2/.digest_passwd realm username' to create(with -c) and modify."
    exit 1
fi

users="$@"
if [ "$#" -eq 0 ]; then
    echo "Error: No arguments provided. Usage: $0 user1 [user2 [user3...]]"
    exit 1
fi

a2enmod dav*

# TODO 新建webdav-{users}.conf 以及 webdav-root.conf，合适地修改已有文件。
cp ./webdav-root.conf /etc/apache2/sites-available/webdav-root.conf

a2ensite webdav-root

for user in $users
do
    cp ./webdav-fox.conf /etc/apache2/sites-available/webdav-${user}.conf
    # 将所有的fox替换成对应的用户名
    sed -i "s/fox/${user}/g" /etc/apache2/sites-available/webdav-${user}.conf

    a2ensite webdav-${user}

done

systemctl restart apache2
systemctl status apache2
