FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000
ENV GID=1000
ENV AWS_SHARED_CREDENTIALS_FILE=/data/aws/credentials
ENV AWS_CONFIG_FILE=/data/aws/config

ADD rootfs /

RUN apk update && apk upgrade && \
  apk add openjdk8-jre-base python3 ffmpeg nss subversion \
  transmission-daemon transmission-cli coreutils \
  tzdata chromium-chromedriver chromium && \
  apk add --virtual build-dependencies curl python3-dev g++ freetype-dev libxslt-dev && \
  S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o s6-overlay.tar.gz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz" && \
  tar xfz s6-overlay.tar.gz -C / && \
  rm -rf s6-overlay.tar.gz && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade -r /requirements.txt && \
  apk del build-dependencies && \
  addgroup -S abc -g 1000 && adduser -S abc -G abc -u 1000

ENTRYPOINT ["/init"]
