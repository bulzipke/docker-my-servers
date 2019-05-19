FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
RUN apk add openjdk8-jre-base python3 python3-dev

COPY rootfs /

CMD ["/setup.sh"]

