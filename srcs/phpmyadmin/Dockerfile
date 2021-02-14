# Using official alpine image as a parent image
FROM alpine:latest

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache php7 php7-fpm php7-mysqli php7-mbstring \
	nginx wget

# Creating a folder for the nginx.pid file & add a 'www' user for nginx
RUN mkdir var/run/nginx
RUN mkdir www && chmod +x www
RUN mkdir www/phpmyadmin
RUN mkdir www/tmp
RUN adduser -D -g 'www' www
RUN chown -R www:www /var/lib/nginx && \
	chown -R www:www www && \
	chown -R www:www www/tmp

# Installing phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
# '--strip-components=NUMBER' is for modifying the filenames of extracted files, '-C' change to directory DIR
RUN tar -xf phpMyAdmin-5.0.4-english.tar.gz --strip-components=1 -C /www/phpmyadmin
RUN rm phpMyAdmin-5.0.4-english.tar.gz

# Copying the nginx configuration, phpmyadmin config file & start script.
COPY srcs/nginx.conf etc/nginx/
COPY srcs/config.inc.php www/
COPY srcs/start.sh .
RUN chmod +x start.sh

EXPOSE 5000

# Start program
CMD sh ./start.sh