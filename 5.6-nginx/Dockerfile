FROM debian:stretch-slim

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME /root/.composer

# Timezone 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get --no-install-recommends --no-install-suggests --yes --quiet install \
        apt-transport-https bash-completion lsb-release ca-certificates wget curl cron apt-utils unzip && \
        rm -rf  /var/lib/apt/lists/* /tmp/* /var/tmp/* \
            /usr/share/doc/* /usr/share/groff/* /usr/share/info/* /usr/share/linda/* \
            /usr/share/lintian/* /usr/share/locale/* /usr/share/man/

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && \
    apt-get --no-install-recommends --no-install-suggests --yes --quiet install \
    nginx php7.2 php7.2-fpm \
    php7.2-zip php7.2-mysql php7.2-pgsql php7.2-mbstring php7.2-intl php7.2-soap php7.2-gd \
    php7.2-dev php7.2-curl php7.2-xml php7.2-pgsql &&\
    apt-get clean && apt-get --yes --quiet autoremove --purge && \
    rm -rf  /var/lib/apt/lists/* /tmp/* /var/tmp/* \
            /usr/share/doc/* /usr/share/groff/* /usr/share/info/* /usr/share/linda/* \
            /usr/share/lintian/* /usr/share/locale/* /usr/share/man/

# Composer 설치
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer
# prestissimo

COPY ./default.conf /etc/nginx/sites-available/default

RUN composer global require hirak/prestissimo

EXPOSE 80

CMD cron && /etc/init.d/php7.2-fpm start && nginx -g "daemon off;"