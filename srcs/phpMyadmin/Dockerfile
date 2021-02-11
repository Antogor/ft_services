FROM alpine:3.12

COPY start.sh /tmp/

RUN apk add phpmyadmin && \
	chmod +x /tmp/start.sh

COPY config.inc.php /etc/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT [ "/tmp/start.sh" ]
