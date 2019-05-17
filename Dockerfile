FROM alpine:latest
MAINTAINER bulzipke <bulzipke@naver.com>

RUN apk update && apk upgrade
# COPY scripts/* /root/

VOLUME /data
WORKDIR data

RUN pwd

CMD ["/bin/sleep infinity"]


# RUN sed -i "2i/mount.sh &" /plex-common.sh
# RUN sed -i "3ibash /setup.sh" /plex-common.sh
# RUN sed -i 's/#user_allow_other/user_allow_other/g' /etc/fuse.conf

# WORKDIR root
# RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
# RUN unzip rclone-current-linux-amd64.zip
# RUN mv rclone-*-linux-amd64/rclone /usr/bin/
# RUN rm -rf rclone*
# RUN chown root:root /usr/bin/rclone
# RUN chmod 755 /usr/bin/rclone

# RUN mkdir -p /data

# COPY scripts/* /

# EXPOSE 32400/tcp

