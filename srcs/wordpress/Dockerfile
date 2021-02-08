FROM alpine:3.12

ENV WORDPRESS_DB_NAME=wordpress
ENV WORDPRESS_DB_USER=agarzon
ENV WORDPRESS_DB_PWD=agarzon
ENV WORDPRESS_DB_HOST=0.0.0.0
ENV WORDPRESS_DB_PORT=3306
ENV WORDPRESS_SVC_IP=192.168.99.103
ENV WORDPRESS_SVC_PORT=5050

COPY start.sh /tmp/

RUN apk add php7 php7-fpm php7-mbstring php7-mysqli php7-json php7-session && apk add wget && \
	wget https://es.wordpress.org/wordpress-latest-es_ES.tar.gz && \
	mkdir -p /var/www && \
	tar -xzvf wordpress-latest-es_ES.tar.gz -C /var/www/ && \
	rm -f wordpress-latest-es_ES.tar.gz && \
	rm -f /var/www/wordpress/wp-config-sample.php && \
	chmod 777 /tmp/start.sh

COPY wp-config.php /var/www/wordpress/

EXPOSE 5050

ENTRYPOINT [ "/tmp/start.sh" ]
