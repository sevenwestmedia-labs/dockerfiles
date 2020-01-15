FROM library/alpine:3.11

RUN apk add --no-cache \
  bind-tools \
  curl \
  openssl \
  tini

ENV AKAMAI_NETWORK=staging

WORKDIR /code
COPY . /code

ENTRYPOINT [ "/code/docker-entrypoint.sh" ]
CMD [ "/bin/sh", "-c", "cat \"$AKAMAI_HOSTSFILE\"" ]

