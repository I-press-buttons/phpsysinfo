FROM php:8.2.35-apache-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends libonig-dev libonig5 pciutils \
    && docker-php-ext-install -j"$(nproc)" mbstring \
    && apt-get purge -y --auto-remove libonig-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /var/www/html/phpsysinfo/
RUN cp /var/www/html/phpsysinfo/phpsysinfo.ini.new \
       /var/www/html/phpsysinfo/phpsysinfo.ini

EXPOSE 80
CMD ["apache2-foreground"]
