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


```
docker buildx build \
--platform linux/amd64,linux/arm64,linux/arm/v7 \
-t haneu89/laravel:82 \
--push .

docker buildx create --name jinwork
docker buildx use jinwork
```