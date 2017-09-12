FROM php:5.6.30-apache

VOLUME ["/var/www"]

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y ruby
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
RUN npm install -g uglify-js uglifycss autoprefixer
RUN gem update --system
RUN gem uninstall sass
RUN gem uninstall compass

RUN gem install sass --pre
RUN apt-get install -y apt-utils
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y freetds-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install json
RUN docker-php-ext-install curl
RUN apt-get install -y libpq-dev
RUN docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql
RUN docker-php-ext-configure pdo_pgsql --with-pgsql
RUN docker-php-ext-install pgsql pdo_pgsql
RUN pecl install apc

RUN useradd -G www-data -d /var/www -s /bin/bash mapas; \
    mkdir -p /var/www/mapasculturais/src/assets; \
    mkdir -p /var/www/mapasculturais/src/files; \
    chown -R mapas:www-data /var/www

RUN a2enmod rewrite
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_LOG_DIR /var/www/log/mapasculturais
ENV APACHE_RUN_USER mapas
ENV APACHE_RUN_GROUP www-data
ENV APACHE_STARTSERVERS 3
ENV APACHE_MAXSPARESERVERS 5
ENV APACHE_MINSPARESERVERS 3
ENV APACHE_DOCUMENT_ROOT /var/www/mapasculturais/src

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www

COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
CMD ["apache2", "-DFOREGROUND"]