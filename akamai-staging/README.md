# akamai-staging-docker

On start, this image adds entries to `/etc/hosts` for our properties that
redirect it to Akamai's staging network.

# How to use

You can run commands within the image, and all requests to WANEWS properties
will be redirected to Akamai's staging network.

The staging hostnames are injeted into `/etc/hosts` at start, so don't
override the docker entrypoint.

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

