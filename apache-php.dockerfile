FROM alpine:latest

RUN apk add php7-apache2 --no-cache
WORKDIR /var/www/localhost/htdocs
COPY scripts/index.php .
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80 443