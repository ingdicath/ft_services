# Using official alpine image as a parent image
FROM alpine:3.12

# Getting the updates for alpine
RUN apk update

# VSFTPD stands for "Very Secure File Transfer Protocol Daemon"
RUN apk add --no-cache vsftpd openssl

# Creating ftp credentials
RUN	mkdir -p /var/ftp
RUN adduser -D grogu -h /var/ftp && \
	echo "grogu:mando" | chpasswd

# Generating ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/vsftpd.key \
	-out /etc/ssl/certs/vsftpd.crt \
	-subj "/C=NL/ST=Noord Holland/L=Amsterdam\
	/O=Codam/CN=ft_services"

# vsftpd config
COPY srcs/vsftpd.conf /etc/vsftpd/
COPY srcs/start.sh .

# Port 20: active mode data transfer. Port 21: explicit FTPS control connections. 
# Port 30000: pasive mode data transfer.
EXPOSE 20 21 30000

CMD sh start.sh