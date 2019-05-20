FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
RUN apk add openjdk8-jre-base python3 ffmpeg nss
RUN apk add --virtual build-dependencies python3-dev g++ freetype-dev libxslt-dev

COPY rootfs /

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade -r /requirements.txt

RUN apk del build-dependencies

CMD ["/setup.sh"]

