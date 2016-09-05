#!/bin/sh
##
# Run dns-forwarder container bound to docker default bridge ip
# using recursor and local domain provided as environment variables
# with fallback to default values.

set -e

DNS_RECURSOR=${DNS_RECURSOR:-8.8.8.8}
DNS_DOMAIN=${DNS_DOMAIN:-local}

bridge_ip="$(docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}')"
docker run --name dns-forwarder --hostname dns-forwarder -d \
           -p ${bridge_ip}:53:53/udp \
           -p ${bridge_ip}:53:53 \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e DNS_RECURSOR=${DNS_RECURSOR} \
           -e DNS_DOMAIN=${DNS_DOMAIN} \
           mcmediacom/dns-forwarder
