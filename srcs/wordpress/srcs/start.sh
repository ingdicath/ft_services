#!/bin/sh
cd /www/

wp db create
wp core install --url=wordpress/ --path=/www --title=Mandalorian --admin_user=grogu --admin_password=mando --admin_email=grogu@mandalorian.com --skip-email
wp option update blogdescription "This is the way"
wp user create Aang editor@avatar.com --role=editor --user_pass=editor
wp user create Katara author@avatar.com --role=author --user_pass=author
wp user create Zuko contributor@avatar.com --role=contributor --user_pass=contributor
wp user create Appa subscriber@avatar.com --role=subscriber --user_pass=subscriber
wp user create Momo subscriber2@avatar.com --role=subscriber --user_pass=subscriber2

wp theme install ashe
wp theme activate ashe
wp plugin install elementor
wp plugin activate elementor

php-fpm7 & nginx -g "daemon off;"