FROM composer:2.8.11 AS composer

FROM php:8.4-cli as build

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
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

RUN cd /compiler \
  && composer install --optimize-autoloader --no-dev

FROM php:8.4-cli

COPY --from=build /compiler/ /compiler/
ADD compile.php /compiler/compile.php
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
