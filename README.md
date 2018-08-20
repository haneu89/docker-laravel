# Docker - laravel Production Container 

## How to use

### Dockerfile

```docker

FROM haneu89/laravel

WORKDIR /app

COPY . ./
COPY .env.production .env

RUN composer install --optimize-autoloader

RUN chown -R www-data:www-data /app

```