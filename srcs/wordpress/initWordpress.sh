#!/bin/sh
#nginx -g 'daemon off;'
#php-fpm7
php -S 0.0.0.0:5050 -t /var/www/wordpress/
