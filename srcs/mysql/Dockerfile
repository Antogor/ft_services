FROM alpine

COPY dataBaseInit.sh /tmp/
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY sqlInit.sh /tmp/
COPY wordpress.sql /tmp/

RUN apk update && apk add mariadb && apk add mariadb-client && \
	rm -rf /var/cache/apk/* && \
	chmod 777 /tmp/sqlInit.sh && chmod 777 /tmp/dataBaseInit.sh

ENV MYSQL_DB_NAME=wordpress
ENV MYSQL_DB_USER=agarzon
ENV MSYQL_DB_PWD=agarzon
ENV MSQL_DB_IP_CLIENT=0.0.0.0
ENV MYSQL_ADMIN=admin
ENV MYSQL_ADMIN_PWD=mysql_admin

EXPOSE 3306

ENTRYPOINT ["/tmp/sqlInit.sh"]
