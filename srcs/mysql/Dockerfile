FROM alpine

COPY init.sql /tmp/
COPY wordpress.sql /tmp/

RUN apk add mysql mysql-client && \
	mysql -u root --password= < /tmp/init.sql && \
	mysql wordpress -u root --password= < /tmp/wordpress.sql

EXPOSE 3306

ENTRYPOINT ["mysql", "start"]
