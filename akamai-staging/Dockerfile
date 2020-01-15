FROM library/alpine:3.11

RUN apk add --no-cache \
  bind-tools \
  curl \
  openssl \
  tini

ENV AKAMAI_NETWORK=staging

WORKDIR /opt/swm/akamai-staging
COPY . /opt/swm/akamai-staging

ENTRYPOINT [ "/opt/swm/akamai-staging/docker-entrypoint.sh" ]

CMD [ "/bin/sh", "-c", "cat /opt/swm/akamai-staging/hosts" ]

