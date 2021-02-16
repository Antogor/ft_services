FROM alpine:3.12

COPY default.conf /tmp/
COPY sshd_config /tmp/
COPY start.sh /tmp/

RUN apk update && apk add nginx openssl openssh openrc && \
	cp /tmp/default.conf /etc/nginx/conf.d/ && \
	ssh-keygen -A && echo "root:root" | chpasswd && \
	mkdir -p /run/nginx && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/agarzon.key \
	-out /etc/ssl/certs/agarzon.crt && \
	openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048 && \
	chmod 777 /tmp/start.sh

COPY index.html /var/www/

EXPOSE 80 443 22 

ENTRYPOINT [ "/tmp/start.sh" ]
