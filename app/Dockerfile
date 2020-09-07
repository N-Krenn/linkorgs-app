FROM php:7.3-apache
RUN apt-get update && \
    apt-get install -y wget gnupg2 libpq5 libpq-dev && docker-php-ext-install pdo pdo_pgsql
COPY ./wait-for-postgres.sh wait-for-postgres.sh
RUN apt-get update
RUN apt-get install -y postgresql-client
RUN chmod +x wait-for-postgres.sh
COPY src/ /var/www/html
EXPOSE 80
