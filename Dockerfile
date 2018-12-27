FROM corfr/tcpdump:latest

RUN \
  apk add --no-cache \
    curl \
    libcap \
    su-exec \
    tzdata

ENV \
  USER_UID=1000 \
  USER_GID=1000 \
  \
  SET_CONTAINER_TIMEZONE=true \
  CONTAINER_TIMEZONE=Europe/Moscow \
  \
  DATA_DIR=/data \
  FILTER_HOST_FROM=

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
