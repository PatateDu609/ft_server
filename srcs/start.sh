#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gboucett <gboucett@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/14 22:53:55 by gboucett          #+#    #+#              #
#    Updated: 2019/12/14 22:54:00 by gboucett         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

WEBDIR="/var/www/localhost"
NGINX_CONF_LNK="/etc/nginx/sites-enabled/localhost.conf"
NGINX_CONF="/etc/nginx/sites-available/localhost.conf"
INDEX=

cd /root
echo "Setting up nginx config file"
rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
mv config_nginx $NGINX_CONF
ln -s $NGINX_CONF $NGINX_CONF_LNK

echo "Installing mkcert (for SSL)"
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64
mv mkcert-v1.4.1-linux-amd64 mkcert
chmod +x mkcert

echo "Setting up mkcert"
./mkcert -install
./mkcert localhost

echo "Installing Phpmyadmin and Wordpress"
tar xf pma.tar.gz
tar xf wordpress.tar.gz
rm -rf pma.tar.gz wordpress.tar.gz
if [ "$INDEX" = "wp" ]; then
	mv wordpress $WEBDIR
else
	echo "Setting index.html"
	mkdir -p $WEBDIR
	mv wordpress $WEBDIR/wordpress
	cp /root/index.html $WEBDIR/index.html
fi
mv pma $WEBDIR/phpmyadmin
chown -R www-data:www-data /var/www
chmod -R 755 /var/www


echo "Setting up Phpmyadmin"
mv config.inc.php $WEBDIR/phpmyadmin

echo "Setting up mysql server"
service mysql start
echo "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';" | mysql -u root

echo "Launching php and Nginx"
service php7.3-fpm start
nginx -g 'daemon off;'
# bash
