# tcpdump for docker

Based on [corfr/tcpdump](https://hub.docker.com/r/corfr/tcpdump/) with configurable user permissions for dump files and configurable timezone.

Also this image is versioned.

You need to add capabilites NET_RAW and NET_ADMIN to docker run to allow capture packets as nonprivileged user.

```
docker run --net=host --cap-add NET_RAW --cap-add NET_ADMIN kaktuss/tcpdump:latest
```
