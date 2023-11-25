FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=kyvo_io
ENV MYSQL_DATABASE=monitro
ENV MYSQL_USER=monitro-java
ENV MYSQL_PASSWORD=kyvo_io

ADD banco-local.sql /docker-entrypoint-initdb.d

EXPOSE 3306
