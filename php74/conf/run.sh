#!/bin/sh

cd /var/www

cron
# php artisan migrate:fresh --seed
php artisan cache:clear
php artisan route:cache

/usr/bin/supervisord -c /etc/supervisord.conf