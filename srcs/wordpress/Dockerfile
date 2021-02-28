# Using official alpine image as a parent image
FROM alpine:3.12

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache wget \
	php7 php7-fpm php7-mysqli php7-mbstring php7-session php7-json php7-phar php7-cli\
	mysql-client nginx

# Creating a folder for the nginx.pid file & add a 'www' user for nginx
RUN mkdir -p /var/run/nginx
RUN adduser -D -g 'www' www
RUN mkdir /www && chmod +x /www
RUN chown -R www:www /var/lib/nginx

# Installing wordpress
RUN wget -nv https://wordpress.org/latest.tar.gz
# '--strip-components=NUMBER' is for modifying the filenames of extracted files, '-C' change to directory DIR
RUN tar xf /latest.tar.gz --strip-components=1 -C /www/ && rm latest.tar.gz

# Copying the wordpress configuration
COPY srcs/wp-config.php /www/

# Downloading wordpress command line interface
RUN wget -nv https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Setup max size for upload files (optional)
RUN cd /etc/php7/ && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 32M/g' php.ini && \
	sed -i 's/post_max_size = 8M/post_max_size = 32M/g' php.ini

# Giving rights to wordpress folders
RUN chown -R www:www /www

#Copying the nginx configuration and setup start.sh file
COPY srcs/nginx.conf /etc/nginx/
COPY srcs/start.sh .

EXPOSE 5050

CMD sh start.sh