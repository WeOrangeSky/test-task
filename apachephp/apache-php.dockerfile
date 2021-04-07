FROM alpine:latest

RUN apk add php7-apache2 --no-cache
WORKDIR /var/www/localhost/htdocs
RUN echo "<?php phpinfo() ?>" > index.php

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80 443