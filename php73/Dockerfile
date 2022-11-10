FROM debian:buster-slim

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME /root/.composer

# Timezone 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 기본 설치
RUN apt-get update \
      && apt-get install -y --no-install-recommends curl wget gnupg cron apt-utils ca-certificates apt-transport-https build-essential \
      && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
      && echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list \
      && apt-get update \
      && apt-get install -y --no-install-recommends supervisor nginx php7.3 php7.3-fpm \ 
      php7.3-zip php7.3-mysql php7.3-pgsql php7.3-mbstring php7.3-intl php7.3-soap php7.3-gd \
      php7.3-dev php7.3-curl php7.3-xml php7.3-redis php7.3-mongodb\
      && rm -rf /var/lib/apt/lists/*

RUN sed -i -e "s/^post_max_size.*/post_max_size = 2G/" /etc/php/7.3/fpm/php.ini \
  -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/" /etc/php/7.3/fpm/php.ini \
  -e "s/^max_file_uploads.*/max_file_uploads = 2000/" /etc/php/7.3/fpm/php.ini \
  -e "s/^memory_limit.*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini \
  -e '/sendfile/i\\tclient_max_body_size 2G;' /etc/nginx/nginx.conf

# Composer 설치
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer
# prestissimo

COPY ./conf/default.conf /etc/nginx/sites-available/default

RUN composer global require hirak/prestissimo

COPY ./conf/laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf
COPY ./conf/start.sh /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start

EXPOSE 80 443


CMD ["/usr/local/bin/start"]

# CMD cron && /etc/init.d/php7.3-fpm start && nginx -g "daemon off;" && php artisan queue:work
