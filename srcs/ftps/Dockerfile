FROM alpine:latest

RUN apk update

# VSFTPD stands for "Very Secure File Transfer Protocol Daemon"
RUN apk add --no-cache vsftpd openssl

# Generating ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/vsftpd.key \
	-out /etc/ssl/certs/vsftpd.crt \
	-subj "/C=NL/ST=Noord Holland/L=Amsterdam\
	/O=Codam/CN=localhost"

# vsftpd config
COPY srcs/vsftpd.conf /etc/vsftpd/
RUN sed -i 's,\r,,;s, *$,,' /etc/vsftpd/vsftpd.conf
RUN mkdir -p ftp/
COPY srcs/start.sh ./ftp/
RUN chmod +x ./ftp/start.sh

# CHEQUEAR EXPOSE PUERTOS EXPOSE 20 21 10000 10001 10002???
EXPOSE 21 21000-21002 

CMD sh ./ftp/start.sh

# CHEQUEAR SI TOCA CREAR UN USUARIO Y UN GRUPO NUEVO (antes ssh)
# Create user with password
#RUN mkdir -p ftp/
#RUN adduser -D diana -h /ftp \
#	echo "diana:pajarito" | chpasswd


