#!/bin/sh

source "/etc/akamai-hostnames"

AKAMAI_HOSTSFILE="/opt/swm/akamai-staging/hosts"

mkdir -p "`dirname $AKAMAI_HOSTSFILE`"

for HOSTS in $AKAMAI_HOSTNAMES; do
  akamai_host="`echo $HOSTS | sed 's/:.*//g'`"
  akamai_staging_host="`echo $akamai_host | sed 's/\.edgekey\.net/.edgekey-staging.net/' | sed 's/\.edgesuite\.net/.edgesuite-staging.net/'`"
  public_hosts="`echo $HOSTS | sed 's/.*://g' | tr ',' ' '`"

  for staging_ip in `dig -t A +short "$akamai_staging_host" | grep -v '\.$'; dig -t AAAA +short "$akamai_staging_host" | grep -v '\.$'; `; do
    cat <<EOF >>"$AKAMAI_HOSTSFILE"
$staging_ip $public_hosts
EOF
  done
done

cat "$AKAMAI_HOSTSFILE" >>/etc/hosts

export AKAMAI_HOSTSFILE
export AKAMAI_HOSTNAMES

