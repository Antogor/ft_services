#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

mariadb-install-db --bootstrap --user=root --datadir="/var/lib/mysql/"

#mysql_secure_installation

#mariadb-install-db -u root

/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/init.sql

##mysql -u root wordpress < wordpress.sql

sleep 5

exec /usr/bin/mysqld --user=root --console
#mariadb-safe --user=root --datadir="/var/lib/mysql/"
