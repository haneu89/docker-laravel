#!/usr/bin/env bash

set -e

service supervisor start
supervisorctl reread
supervisorctl update
supervisorctl start laravel-worker:*

echo "run cron job"
cron

echo "php 7.3 fpm start"
/etc/init.d/php7.3-fpm start

# echo "laravel queue worker start"
# exec /app/artisan queue:work --tries=3 --timeout=90 &

echo "nginx start"
nginx -g "daemon off;"

# while [ true ]
# do
#   echo "laravel schedule run"
#   php /app/artisan schedule:run --verbose --no-interaction &
#   sleep 60
# done