FROM alpine

COPY mariadb-server.cnf /tmp/ 
COPY sqlInit.sh /tmp/
COPY wordpress.sql /tmp/
COPY init.sql /tmp/

RUN apk update && apk add mariadb mariadb-client && \
	cp /tmp/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf && \
	chmod 777 /tmp/sqlInit.sh
#rm -rf /var/lib/mysql; mkdir -p /var/lib/mysql /var/run/mysqld; \
#	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
#	chmod 777 /var/run/mysqld/ && 

ENV MYSQL_DB_NAME=wordpress
ENV MYSQL_DB_USER=agarzon
ENV MSYQL_DB_PWD=agarzon
ENV MYSQL_ADMIN=admin
ENV MYSQL_ADMIN_PWD=mysql_admin

EXPOSE 3306

ENTRYPOINT [ "/tmp/sqlInit.sh" ]

