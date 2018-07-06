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

su-exec user /usr/sbin/tcpdump $@ &
child=$!

trap "kill $child" SIGTERM SIGINT
wait "$child"
trap - SIGTERM SIGINT
wait "$child"
