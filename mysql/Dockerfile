FROM alpine:latest

ENV MYSQL_USER_PASSWORD=mysql
ENV MYSQL_USER=mysql

RUN apk add mysql --no-cache

COPY ./fc.sh .
RUN chmod +x fc.sh
RUN /bin/sh fc.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306
ENTRYPOINT ["/usr/bin/mysqld", "--user=mysql"]