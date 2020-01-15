#!/bin/sh

AKAMAI_HOSTNAMES='
perthnow.com.au.edgekey.net:perthnow.com.au,www.perthnow.com.au,content.perthnow.com.au,images.perthnow.com.au,at.perthnow.com.au
dev.perthnow.com.au.edgekey.net:dev-images.perthnow.com.au
dev-images.thewest.com.au.edgekey.net:dev-images.thewest.com.au
stg.san.perthnow.com.au.edgekey.net:stg-at.perthnow.com.au,stg-content.perthnow.com.au,stg-images.perthnow.com.au,stg.perthnow.com.au
thewest-stg.pipeline.edgekey.net:stg.thewest.com.au,stg-images.thewest.com.au,stg-content.thewest.com.au
regionals.stg.pipeline.edgekey.net:stg.swtimes.com.au,stg.soundtelegraph.com.au,stg.pilbaranews.com.au,stg.northwesttelegraph.com.au,stg.narroginobserver.com.au,stg.midwesttimes.com.au,stg.mbtimes.com.au,stg.kimberleyecho.com.au,stg.kalminer.com.au,stg.harveyreporter.com.au,stg.gsherald.com.au,stg.geraldtonguardian.com.au,stg.countryman.com.au,stg.bunburyherald.com.au,stg.broomead.com.au,stg.bdtimes.com.au,stg.amrtimes.com.au,stg.albanyadvertiser.com.au
images.thewest.com.au.edgekey.net:content.thewest.com.au,images.thewest.com.au,thewest.com.au,www.thewest.com.au
regionals.edgekey.net:regionals.thewest.com.au,www.albanyadvertiser.com.au,www.amrtimes.com.au,www.bdtimes.com.au,www.broomead.com.au,www.bunburyherald.com.au,www.countryman.com.au,www.geraldtonguardian.com.au,www.gsherald.com.au,www.harveyreporter.com.au,www.kalminer.com.au,www.kimberleyecho.com.au,www.mbtimes.com.au,www.midwesttimes.com.au,www.narroginobserver.com.au,www.northwesttelegraph.com.au,www.pilbaranews.com.au,www.soundtelegraph.com.au,www.swtimes.com.au
dev-images-7news.swmdigital.io.edgesuite.net:dev-images-7news.swmdigital.io
prd-7news.edgekey.net:www.7news.com.au,images.7news.com.au,content.7news.com.au,7news.com.au
stg-7news.edgekey.net:stg.7news.com.au,stg-images.7news.com.au,stg-content.7news.com.au
'

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

