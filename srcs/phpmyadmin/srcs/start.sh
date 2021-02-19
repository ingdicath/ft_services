#!/bin/sh
# php-fpm7
# nginx
# (php --help) -S, --server addr:port; Start the internal web server || -t, --docroot; Specify the document root for the internal web server
# nginx & php -S 0.0.0.0:5000 -t /www/

php-fpm7 & nginx -g "daemon off;"