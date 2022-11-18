FROM composer:2.4.3 AS composer

FROM php:8.1-cli

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
  bash \
  git \
  unzip \
  zlib1g-dev \
  libzip-dev

RUN docker-php-ext-install zip

RUN mkdir -p /composer && mkdir -p /compiler

ENV COMPOSER_HOME /composer

ENV COMPOSER_ALLOW_SUPERUSER 1

ADD composer.json /compiler/composer.json

ADD composer.lock /compiler/composer.lock

ADD compile.php /compiler/compile.php

RUN cd /compiler \
  && composer install \
  && cd -

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
