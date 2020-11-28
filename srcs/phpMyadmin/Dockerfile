FROM alpine

ENV DB_NAME=wordpress
ENV DB_USERNAME=agarzon
ENV DB_PWD=agarzon
ENV DB_HOST=0.0.0.0

COPY initPhp.sh /tmp/

RUN apk add phpmyadmin && chmod 777 /tmp/initPhp.sh

COPY config.inc.php /etc/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT [ "/tmp/initPhp.sh" ]
