FROM php:8.0-fpm

# Set working directory
WORKDIR /var/www

# Add docker php ext repo
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached



# Install dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev pkg-config libssl-dev openssl\
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    git \
    curl \
    lua-zlib-dev \
    libmemcached-dev \
    cron \
    vim \
    nginx

# Install supervisor
RUN apt-get install -y supervisor

RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN pecl install redis && docker-php-ext-enable redis

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy code to /var/www
# COPY --chown=www:www-data . /var/www

# add root to www group
# RUN chmod -R ug+w /var/www/storage

# Copy nginx/php/supervisor configs
COPY conf/supervisor.conf /etc/supervisord.conf
COPY conf/php.ini /usr/local/etc/php/conf.d/app.ini
COPY conf/nginx.conf /etc/nginx/sites-enabled/default
COPY conf/run.sh /var/run.sh

# PHP Error Log Files
RUN mkdir /var/log/php
RUN touch /var/log/php/errors.log && chmod 777 /var/log/php/errors.log

# Deployment steps
# RUN composer install --optimize-autoloader --no-dev
RUN echo "* * * * * php /app/artisan schedule:run >> /dev/null 2>&1" | crontab
RUN chmod +x /var/run.sh

EXPOSE 80
ENTRYPOINT ["/var/run.sh"]