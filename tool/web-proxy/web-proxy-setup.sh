#!/bin/sh

admin_email=$1
web_hostname=$2
git_server_addr=$3
webdav_server_addr=$4
webdav_users=("${@:5}")

if [ -z "$admin_email" -o -z "$web_hostname" -o -z "$git_server_addr" -o -z "$webdav_server_addr" -o "${#webdav_users[@]}" -eq 0 ]; then
  echo "Usage: $0 admin_email web_hostname git_server_addr webdav_server_addr webdav_user1 [webdav_user2 [webdav_user3 ...]]"
  exit 1
fi


apt-get -y install apache2
apt-get -y install apache2-utils 
a2enmod proxy_http
a2enmod ssl
a2enmod dav*
a2enmod headers

cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak

# ServerRoot行后插入ServerName
sed -i "0,/ServerRoot \"[^\"]*\"/s//&\nServerName $web_hostname\n/" /etc/apache2/apache2.conf

# 修改管理员邮箱
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-available/000-default.conf
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-enabled/000-default.conf

systemctl restart apache2

# 获得证书
apt-get -y install certbot

certbot certonly --webroot -w /var/www/html -d $web_hostname

# 修改SSL页面管理员邮箱
sed -i 's/^\(\s*ServerAdmin\) .*/\1 '"$admin_email"'/' /etc/apache2/sites-available/default-ssl.conf

# 修改证书文件地址
cert_file="/etc/letsencrypt/live/$web_hostname/cert.pem"
cert_key_file="/etc/letsencrypt/live/$web_hostname/privkey.pem"
cert_chain_file="/etc/letsencrypt/live/$web_hostname/chain.pem"

sed -i 's#^\(\s*SSLCertificateFile\s\+\).*#\1'"$cert_file"'#' /etc/apache2/sites-available/default-ssl.conf
sed -i 's#^\(\s*SSLCertificateKeyFile\s\+\).*#\1'"$cert_key_file"'#' /etc/apache2/sites-available/default-ssl.conf

sed -i 's,#\(\s*SSLCertificateChainFile\s\+.*\),\1,' /etc/apache2/sites-available/default-ssl.conf
sed -i 's,^\(\s*SSLCertificateChainFile\s\+\).*,\1'"$cert_chain_file"',' /etc/apache2/sites-available/default-ssl.conf

a2ensite default-ssl

systemctl restart apache2

# git代理

cp ./git-proxy.conf /etc/apache2/sites-available/git-proxy.conf
sed -i 's/192\.168\.37\.225:3000/'"$git_server_addr"'/g' /etc/apache2/sites-available/git-proxy.conf

a2ensite git-proxy

# webdav 代理

cp ./webdav-root-proxy.conf /etc/apache2/sites-available/webdav-root-proxy.conf
sed -i 's/192\.168\.37\.32/'"$webdav_server_addr"'/g' /etc/apache2/sites-available/webdav-root-proxy.conf

a2ensite webdav-root-proxy

for user in "${webdav_users[@]}"
do
    cp ./webdav-fox-proxy.conf /etc/apache2/sites-available/webdav-${user}-proxy.conf
    sed -i 's/192\.168\.37\.32/'"$webdav_server_addr"'/g' /etc/apache2/sites-available/webdav-${user}-proxy.conf
    sed -i 's/fox/'"$user"'/g' /etc/apache2/sites-available/webdav-${user}-proxy.conf

    a2ensite webdav-${user}-proxy
done


systemctl restart apache2
systemctl status apache2
