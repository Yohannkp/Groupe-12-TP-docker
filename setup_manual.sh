#!/bin/bash

set -e

docker network inspect db_network >/dev/null 2>&1 || docker network create db_network
docker network inspect site_network >/dev/null 2>&1 || docker network create site_network
docker volume inspect db_volume >/dev/null 2>&1 || docker volume create db_volume

docker build -t mysql ./mysql
docker build -t app ./app
docker build -t nginx ./nginx

docker rm -f mysql_container 2>/dev/null || true
docker run -d \
  --name mysql_container \
  --network db_network \
  --network-alias mysql \
  -v db_volume:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=mydb \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=pass \
  -p 5655:5655 \
  mysql

docker rm -f app_container 2>/dev/null || true
docker run -d \
  --name app_container \
  --network db_network \
  --network-alias app \
  -e DB_HOST=mysql \
  -e DB_PORT=5655 \
  -e DB_USER=user \
  -e DB_PASSWORD=pass \
  -e DB_NAME=mydb \
  -p 4743:4743 \
  app

docker network disconnect site_network app_container 2>/dev/null || true
docker network connect --alias app site_network app_container

docker rm -f nginx_container 2>/dev/null || true
docker run -d \
  --name nginx_container \
  --network site_network \
  -p 5423:824 \
  -v $(pwd)/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf \
  nginx
