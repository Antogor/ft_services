#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chmod 777 -R /run/mysqld
fi

mysql_install_db --user=mysql --datadir=/var/lib/mysql/ #--defaults-file=~/.my.cnf
nohup /tmp/dataBaseInit.sh &
cd /usr ; /usr/bin/mysqld_safe --datadir="/var/lib/mysql/"
