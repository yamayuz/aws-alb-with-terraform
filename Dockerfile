FROM nginx:1.18.0-alpine AS nginx
RUN apk add --no-cache --update tzdata &&\
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./src/index.html /var/www/html/index.html
# COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
