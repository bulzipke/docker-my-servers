FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000 \
    GID=1000 \
	TARGET_DIR=/data \
	AWS_SHARED_CREDENTIALS_FILE=/data/aws/credentials \
	AWS_CONFIG_FILE=/data/aws/config

ADD rootfs /

RUN apk update && apk upgrade && \
  apk add openjdk8-jre-base python3 py3-pip ffmpeg nss \
  coreutils \
  tzdata libxslt-dev \
  libffi-dev && \
  addgroup -S abc -g 1000 && adduser -S abc -G abc -u 1000 && \
  apk add --virtual build-dependencies curl python3-dev g++ freetype-dev libxslt-dev && \
  S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o /tmp/s6-overlay-noarch.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz" && \
  tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
  curl -o /tmp/s6-overlay-x86_64.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-x86_64.tar.xz" && \
  tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade -r /requirements.txt && \
  chmod +x /etc/cont-init.d/* && \
  chmod +x /etc/services.d/10-cron/run && \
  chmod +x /usr/local/bin/run_servers.py && \
  rm -rf /tmp/* && \
  apk del build-dependencies

ENTRYPOINT ["/init"]
