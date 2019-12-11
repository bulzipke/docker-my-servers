FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

ENV UID=1000
ENV GID=1000
ENV TARGET_DIR=/data
ENV AWS_SHARED_CREDENTIALS_FILE=/data/aws/credentials
ENV AWS_CONFIG_FILE=/data/aws/config

ADD rootfs /

RUN apk update && apk upgrade && \
  apk add openjdk8-jre-base python3 ffmpeg nss subversion \
  transmission-daemon transmission-cli coreutils \
  tzdata chromium-chromedriver chromium git npm && \
  addgroup -S abc -g 1000 && adduser -S abc -G abc -u 1000 && \
  apk add --virtual build-dependencies curl python3-dev g++ freetype-dev libxslt-dev && \
  S6_VERSION=$(curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o s6-overlay.tar.gz -L "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz" && \
  tar xfz s6-overlay.tar.gz -C / && \
  rm -rf s6-overlay.tar.gz && \
  git clone https://github.com/l3uddz/cloudplow /opt/cloudplow && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade -r /requirements.txt -r /opt/cloudplow/requirements.txt && \
  ln -s /opt/cloudplow/cloudplow.py /usr/local/bin/cloudplow && \
  chown -R abc:abc /opt/cloudplow && \
  curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip rclone-current-linux-amd64.zip && \
  mv rclone-*-linux-amd64/rclone /usr/bin/ && \
  rm -rf rclone* && \
  chown root:root /usr/bin/rclone && \
  chmod 755 /usr/bin/rclone && \
  curl -o file.tar.gz -L https://github.com/pusher/oauth2_proxy/releases/download/v4.0.0/oauth2_proxy-v4.0.0.linux-amd64.go1.12.1.tar.gz && \
  tar xfz file.tar.gz && \
  mv oauth2*/* /usr/bin/ && \
  rm -rf file.tar.gz && \
  chown root:root /usr/bin/oauth2_proxy && \
  npm i -g green-tunnel && \
  apk del build-dependencies

ENTRYPOINT ["/init"]
