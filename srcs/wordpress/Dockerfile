FROM alpine

ENV WORDPRESS_DB_NAME=wordpress
ENV WORDPRESS_DB_USER=agarzon
ENV WORDPRESS_DB_PWD=agarzon
ENV WORDPRESS_DB_HOST=0.0.0.0
ENV WORDPRESS_DB_PORT=3306
ENV WORDPRESS_SVC_IP=192.168.99.103
ENV WORDPRESS_SVC_PORT=5050

COPY initWordpress.sh /tmp/

RUN apk add php7 php7-fpm php7-mbstring php7-mysqli php7-json && apk add wget && \
	wget https://es.wordpress.org/wordpress-latest-es_ES.tar.gz && \
	mkdir -p /www/ && \
	tar -xzvf wordpress-latest-es_ES.tar.gz -C www/ && \
	rm -f wordpress-latest-es_ES.tar.gz && \
	rm -f /www/wordpress/wp-config-sample.php && \
	chmod 777 /tmp/initWordpress.sh

COPY wp-config.php /www/wordpress/

EXPOSE 5050

ENTRYPOINT [ "/tmp/initWordpress.sh" ]
