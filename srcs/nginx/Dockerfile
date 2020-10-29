FROM alpine

COPY default.conf /tmp/
COPY sshd_config /tmp/
COPY index.html /var/www/html/

RUN apk update && apk add nginx openssl openssh && \
			cp /tmp/default.conf /etc/nginx/conf.d/ && \
			ssh-keygen -A && echo "root:root" | chpasswd && \
			mkdir -p /run/nginx && \
			openssl req -x509 -nodes -days 365 \
			-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
			-keyout /etc/ssl/private/agarzon.key \
			-out /etc/ssl/certs/agarzon.crt

EXPOSE 80 443 22 

ENTRYPOINT /usr/sbin/sshd -f /tmp/sshd_config; nginx -g 'daemon off;'
