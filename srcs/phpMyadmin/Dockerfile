FROM alpine

ENV DB_NAME=wordpress
ENV DB_USERNAME=agarzon
ENV DB_PWD=agarzon
ENV DB_HOST=0.0.0.0

COPY initPhp.sh /tmp/

RUN apk add phpmyadmin && \
#	apk add wget && apk add php7 php7-fpm php7-mbstring php7-mysqli php7-json php7-session && \
#	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz && \
#	tar -xzvf phpMyAdmin-5.0.2-all-languages.tar.gz && \
#  	rm -f phpMyAdmin-5.0.2-all-languages.tar.gz && \
#	mv -f phpMyAdmin-5.0.2-all-languages /var/www/phpmyadmin && \
#	rm -f /var/www/phpmyadmin/config.sample.inc.php && \
#	chmod -R 755 /var/www/* && \
	chmod +x /tmp/initPhp.sh

#COPY config.inc.php /var/www/phpmyadmin/
COPY config.inc.php /etc/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT [ "sh", "/tmp/initPhp.sh" ]
