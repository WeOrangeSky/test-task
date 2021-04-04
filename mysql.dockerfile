FROM alpine:latest

RUN apk add mysql --no-cache

COPY scripts/start.sh .
RUN chmod +x start.sh

ENV MYSQL_USER_PASSWORD=mysql
ENV MYSQL_USER=mysql

VOLUME ["/var/lib/mysql"]

EXPOSE 3306
CMD ["sh","start.sh"]