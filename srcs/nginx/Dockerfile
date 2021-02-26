# Using official alpine image as a parent image
FROM alpine:3.12

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache nginx openssl

# Create new user
RUN adduser -D 'www' -g www

# Creating and prepare directories
RUN mkdir /www && chmod +x /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	mkdir -p /run/nginx
COPY srcs/index.html /www/
COPY srcs/image/ /www/image/

# Generating ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt \
	-subj "/C=NL/ST=Noord Holland/L=Amsterdam\
	/O=Codam/CN=localhost"

# Nginx config
COPY srcs/nginx.conf /etc/nginx/
COPY srcs/start.sh .
RUN chmod +x start.sh

EXPOSE 80 443

# Start program
CMD	sh start.sh