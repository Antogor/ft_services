#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

mariadb-install-db --bootstrap --user=root --datadir="/var/lib/mysql/"

#mysql_secure_installation

#mariadb-install-db -u root

openrc
touch /run/openrc/softlevel

service mariadb start
#/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/init.sql

#mysql -u root wordpress < wordpress.sql
#mysql -u root --execute="CREATE DATABASE wordpress;"
#mysql -u root --execute="CREATE USER 'agarzon'@'%' IDENTIFIED by 'agarzon'; GRANT ALL PRIVILEGES ON *.* TO 'agarzon'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
mysql -u root --execute="CREATE DATABASE wordpress;"
mysql -u root --execute="CREATE USER 'agarzon' IDENTIFIED by 'agarzon';"
mysql -u root --execute="GRANT USAGE ON *.* TO 'agarzon'@'localhost' IDENTIFIED by 'agarzon';"
mysql -u root --execute="GRANT USAGE ON *.* TO 'agarzon'@'%' IDENTIFIED by 'agarzon';"
mysql -u root --execute="GRANT ALL privileges ON *.* TO 'agarzon'@'localhost'; USE wordpress;"
mysql -u root --execute="GRANT ALL privileges ON *.* TO 'agarzon'@'%'; USE wordpress; FLUSH PRIVILEGES;"

sleep infinity

#exec /usr/bin/mysqld --user=root --console
#mariadb-safe --user=root --datadir="/var/lib/mysql/"
