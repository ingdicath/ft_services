# Using official alpine image as a parent image
FROM alpine:latest

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache php7 php7-fpm php7-mysqli php7-mbstring php7-session php7-json \
	nginx wget

# Updating phpmyadmin version
ENV PMA_VERSION 5.0.4

# Creating a folder for the nginx.pid file & add a 'www' user for nginx
RUN mkdir -p /var/run/nginx
RUN mkdir -p /www/tmp && chmod +x /www && chmod 777 /www/tmp

RUN adduser -D 'www' -g www
RUN chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	chown -R www:www /www/tmp

# Installing phpmyadmin
# '--strip-components=NUMBER' is for modifying the filenames of extracted files, '-C' change to directory DIR
RUN wget -nv https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-english.tar.gz
RUN tar -xf phpMyAdmin-${PMA_VERSION}-english.tar.gz --strip-components=1 -C /www/
RUN rm phpMyAdmin-${PMA_VERSION}-english.tar.gz

# Copying the nginx configuration, phpmyadmin config file & start script.
COPY srcs/nginx.conf /etc/nginx/
COPY srcs/config.inc.php /www/
COPY srcs/start.sh .

EXPOSE 5000

# Start program
CMD sh ./start.sh