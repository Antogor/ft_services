#!/bin/sh
openrc
touch /run/openrc/softlevel
service nginx start
/usr/sbin/sshd -f /tmp/sshd_config
sleep infinity 
