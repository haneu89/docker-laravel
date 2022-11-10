# LEMP



## 사용법



`Dockerfile`

```dockerfile
FROM haneu89/apm:laravel

WORKDIR /app

COPY . ./

RUN composer install --optimize-autoloader

RUN chown -R www-data:www-data /var/www
RUN php artisan config:cache
```



`.dockerignore`

```.
/vendor
```



`script.sh`

```shell
docker build -t laravel-app .
docker stop laravel-app
docker run -r \
	--restart=always \
	-p 8000:80\
	laravel-app
```

