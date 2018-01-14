FROM php:7-fpm-alpine

# update
RUN apk update --no-cache  && apk upgrade

# custom php.ini
ADD phabric-php-ini.ini /usr/local/etc/php/conf.d/phabric-php-ini.ini

# bash
RUN apk add bash bash-doc bash-completion
RUN echo 'export PS1="[\u@phabric_core] \W # "' >> /root/.profile
# pygmentize
RUN apk add py-pygments

# git
RUN apk add git

# build essence
RUN apk add alpine-sdk

# autoconf
RUN apk add --update --virtual autoconf

# needed extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring iconv mysqli pcntl

# gd
RUN apk add freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} gd
RUN apk del freetype-dev libpng-dev libjpeg-turbo-dev

# APCu 
RUN pecl install apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

# opcache, no needed (bundled) from php 5.5+
# docker-php-ext-install opcache

# phabric
RUN mkdir /codegym
WORKDIR /codegym
RUN git clone https://github.com/phacility/libphutil.git
RUN git clone https://github.com/phacility/arcanist.git
RUN git clone https://github.com/phacility/phabricator.git
