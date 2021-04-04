FROM alpine:latest

RUN apk add apache2 php$phpverx-apache2 --no-cache
WORKDIR /var/www/localhost/htdocs
COPY scripts/index.php .
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80 443