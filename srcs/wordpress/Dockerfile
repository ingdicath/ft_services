FROM alpine:latest

RUN apk update

RUN apk add --no-cache wget \
	php-fpm php-mysqli php-cli php-mbstring \
	nginx

# Creating a folder for the nginx.pid file & add a 'www' user for nginx
RUN mkdir -p /var/run/nginx
RUN adduser -D -g 'www' www
RUN mkdir /www && chmod +x /www
RUN chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

# Installing wordpress
RUN wget -nv https://wordpress.org/latest.tar.gz
# '--strip-components=NUMBER' is for modifying the filenames of extracted files, '-C' change to directory DIR
RUN tar xf /latest.tar.gz --strip-components=1 -C /www/ && rm latest.tar.gz

# Copy the wordpress configuration
COPY srcs/wp-config.php ./www/

# download wordpress command line interface
RUN wget -nv https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#Copy the nginx configuration and setup start.sh file
COPY srcs/nginx.conf /etc/nginx/
COPY srcs/start.sh .
RUN chmod +x start.sh

EXPOSE 5050

CMD sh ./start.sh

#INVESTIGAR PROPOSITO DE CREAR mkdir -p /var/run/nginx