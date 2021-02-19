#!/bin/sh
cd /www/

wp core is-installed
if [ $? == 1 ]; then
	wp db create
	wp core install --title=Mandalorian --admin_user=grogu --admin_password=mando --admin_email=dsalaman@student.codam.nl --skip-email --url=192.168.99.100:5050
	wp user create Aang editor@avatar.com --role=editor --user_pass=editor
	wp user create Katara author@avatar.com --role=author --user_pass=author
	wp user create Zuko contributor@avatar.com --role=contributor --user_pass=contributor
	wp user create Appa subscriber@avatar.com --role=subscriber --user_pass=subscriber
	wp user create Momo subscriber2@avatar.com --role=subscriber --user_pass=subscriber2
else
    echo "Wordpress was already installed in the /www directory"
fi
wp theme install ashe
wp theme activate ashe

php-fpm7 & nginx -g "daemon off;"