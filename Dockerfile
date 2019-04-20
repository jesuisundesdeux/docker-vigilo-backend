FROM php:7.2-apache

MAINTAINER Bruno Adele <brunoadele@gmail.com>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev

# Activate php extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysqli exif

# Activate phpunit
RUN curl -L https://phar.phpunit.de/phpunit-8.phar > /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

# Activate php log
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"