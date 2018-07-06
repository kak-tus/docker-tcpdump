FROM corfr/tcpdump:latest

RUN \
  apk add --no-cache \
    libcap \
    su-exec

ENV \
  USER_UID=1000 \
  USER_GID=1000 \
  \
  SET_CONTAINER_TIMEZONE=true \
  CONTAINER_TIMEZONE=Europe/Moscow

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]