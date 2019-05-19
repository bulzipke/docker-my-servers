FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
RUN apk add openjdk8-jre-base python3

COPY rootfs /

WORKDIR data

CMD ["./run_servers.py", "while sleep 3600; do :; done"]

