#!/usr/bin/env sh

if [ "$SET_CONTAINER_TIMEZONE" = "true" ]; then
    echo "$CONTAINER_TIMEZONE" > /etc/timezone \
    && ln -sf "/usr/share/zoneinfo/$CONTAINER_TIMEZONE" /etc/localtime
    echo "Container timezone set to: $CONTAINER_TIMEZONE"
else
    echo "Container timezone not modified"
fi

setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

addgroup -g $USER_GID user
adduser -h /home/user -G user -D -u $USER_UID user

chown -R user:user "$DATA_DIR"

filter_host=""

if [ -n "$FILTER_HOST_FROM" ]; then
  host=$(curl -s "$FILTER_HOST_FROM")
  if [ -n "$host" ]; then
    filter_host="and host $host"
    echo "$filter_host"
  fi
fi

su-exec user /usr/sbin/tcpdump $@ $filter_host &
child=$!

trap "kill $child" SIGTERM SIGINT
wait "$child"
trap - SIGTERM SIGINT
wait "$child"
