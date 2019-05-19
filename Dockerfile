FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
RUN apk add openjdk8-jre-base python3 python3-dev ffmpeg g++

COPY rootfs /

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade -r /requirements.txt

CMD ["/setup.sh"]

