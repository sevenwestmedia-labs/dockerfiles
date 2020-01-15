#!/bin/sh

if [ "$AKAMAI_NETWORK" == "staging" ]; then
  source "`dirname $0`/update-hosts.sh"
fi

if [ -x '/sbin/tini' ]; then
  exec /sbin/tini -- "$@"
fi

exec "$@"

