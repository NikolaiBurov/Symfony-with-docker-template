#PHP 8.x RC2!
FROM php:8.1.1-apache

USER root

WORKDIR /var/www/html

#Update!
RUN apt-get update

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Install zip+icu dev libs + pgsql dev support
RUN apt-get install libzip-dev zip libicu-dev libpq-dev -y

#Install PHP extensions zip and intl (intl requires to be configured)
RUN docker-php-ext-install zip && docker-php-ext-configure intl && docker-php-ext-install intl

# Add MySQL and Postgres/pgsql support
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-install pdo_pgsql pgsql

#Required for htaccess rewrite rules
RUN a2enmod rewrite

COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf

COPY .env /var/www/html/.env

COPY --chown=www-data:www-data ./src /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

