FROM php:7.4-apache
# UPDATE & UPGRADE
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    apt-utils \
    # https://packages.debian.org/stretch/g++
    g++ \ 
    # https://packages.debian.org/sid/libicu-dev
    libicu-dev \
    # https://packages.debian.org/buster/libpq-dev
    libpq-dev \
    # https://packages.debian.org/stretch/libzip-dev
    libzip-dev \
    # https://packages.debian.org/sid/zip
    zip \
    # https://packages.debian.org/stretch/unzip
    unzip \
    # https://packages.debian.org/buster/zlib1g-dev
    zlib1g-dev \
    #
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    # https://packages.debian.org/testing/web/curl
    curl \
    # Editor
    nano \
    # NodeJS
    nodejs 

# PHP EXTENSIONS
# mysqli (backward compatibility)
# https://www.php.net/manual/en/book.mysqli.php
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
# MySQL
# https://www.php.net/manual/en/ref.pdo-mysql.php
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
# PostgreSQL and Utils
RUN docker-php-ext-install \
    # https://www.php.net/manual/en/book.exif.php
    exif \
    # https://www.php.net/manual/en/book.intl.php
    intl \
    # https://www.php.net/manual/en/book.opcache.php
    opcache \
    # https://www.php.net/manual/en/book.pdo.php
    pdo \
    # https://www.php.net/manual/en/ref.pdo-pgsql.php
    pdo_pgsql \
    # https://www.php.net/manual/en/book.pgsql.php
    pgsql \
    #
    mbstring \
    #
    zip 
    # https://www.php.net/manual/en/book.image.php
    # gd

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd

# BCMatch dependency for Laravel
# https://www.php.net/manual/en/book.bc.php
RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath

# INSTALL PHP COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# INSTALL NODEJS/NPM
# RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

EXPOSE 80
EXPOSE 443

# Work directory
WORKDIR /var/www/c19-dicotec

RUN a2enmod headers
RUN a2enmod rewrite

# Change user permission and enable mod_rewrite
#RUN chown -R www-data:www-data /var/www/laravel && a2enmod rewrite
