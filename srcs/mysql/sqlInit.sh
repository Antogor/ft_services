#!/bin/sh


mariadb-install-db -u root

mysqld -u root < /tmp/init.sql

#mysql -u root --execute="CREATE DATABASE wordpress;"
#
##mysql -u root wordpress < wordpress.sql
#
#mysql -u root --execute="CREATE USER 'agarzon'@'%' IDENTIFIED BY 'agarzon'; GRANT ALL PRIVILEGES ON *.* TO 'agarzon'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"

sleep infinite
