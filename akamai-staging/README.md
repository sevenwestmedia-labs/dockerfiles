# akamai-staging-docker

On start, this image adds entries to `/etc/hosts` for our properties that
redirect it to Akamai's staging network.

# How to use

You can run commands within the image, and all requests to WANEWS properties
will be redirected to Akamai's staging network.

The staging hostnames are injeted into `/etc/hosts` at startup, so if you
override the docker entrypoint, you'll need to call 
`/opt/swm/akamai-staging/update-hosts.sh`.

## Run commands directly

```
docker run --rm -it -v `pwd`:/pwd -w /pwd sevenwestmedialabs/akamai-staging:latest <command>
```

## Extend the image

```
FROM sevenwestmedialabs/akamai-staging:latest

WORKDIR /tests
COPY ./tests .
CMD [ "./run-my-tests" ]

```

## Multi-stage build

For multi-stage builds, make sure to set `AKAMAI_NETWORK=staging`, and either
use `ENTRYPOINT ["/opt/swm/akamai-stating/docker-entrypoint.sh"]` or call
`/opt/swm/akamai-staging/update-hosts.sh`:

```
FROM sevenwestmedialabs/akamai-staging:latest AS source

FROM library/archlinux:latest
ENV AKAMAI_NETWORK=staging

RUN pacman -Sy --noconfirm \
  bind-tools 

COPY --from=source /opt/swm/akamai-staging /opt/swm/akamai-staging

ENTRYPOINT ["/opt/swm/akamai-staging/docker-entrypoint.sh"]

CMD cat /etc/hosts
```

