FROM alpine:3.12

COPY vsftpd.conf /tmp/

RUN apk update && apk add vsftpd && apk add openssl && \
	echo "root:root" | chpasswd && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/agarzon.key \
	-out /etc/ssl/certs/agarzon.crt

EXPOSE 21 30021

ENTRYPOINT /usr/sbin/vsftpd /tmp/vsftpd.conf 
