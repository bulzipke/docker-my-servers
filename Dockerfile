FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

COPY rootfs /

RUN apk update && apk upgrade && \
  apk add openjdk8-jre-base python3 ffmpeg nss subversion transmission-daemon && \
  apk add --virtual build-dependencies python3-dev g++ freetype-dev libxslt-dev && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade -r /requirements.txt && \
  apk del build-dependencies

CMD ["/setup.sh"]
