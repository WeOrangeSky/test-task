FROM alpine:latest

ENV MYSQL_USER_PASSWORD=mysql
ENV MYSQL_USER=mysql

RUN apk add mysql --no-cache

COPY ./fc.sh .
RUN chmod +x start.sh
RUN /bin/sh start.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306
ENTRYPOINT ["/usr/bin/mysqld", "--user=mysql"]