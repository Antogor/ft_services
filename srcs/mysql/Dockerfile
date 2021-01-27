FROM alpine

COPY mariadb-server.cnf /tmp/ 
COPY start.sh /tmp/
COPY wordpress.sql /tmp/
COPY init.sql /tmp/
COPY agarzon.sql /tmp/

RUN apk update && apk add mariadb mariadb-client openrc && \
	cp /tmp/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf && \
	chmod 777 /tmp/start.sh

ENV MYSQL_DB_NAME=wordpress
ENV MYSQL_DB_USER=agarzon
ENV MSYQL_DB_PWD=agarzon
ENV MYSQL_ADMIN=admin
ENV MYSQL_ADMIN_PWD=mysql_admin

EXPOSE 3306

ENTRYPOINT [ "/tmp/start.sh" ]

