#!/bin/sh

mariadb-install-db --bootstrap --user=root --datadir="/var/lib/mysql/"
openrc
touch /run/openrc/softlevel
service mariadb start

mysql -u root --password= < /tmp/init.sql
mysql wordpress -u agarzon --password=agarzon < /tmp/wordpress.sql

sleep infinity
