#!/bin/sh

set -e

glide install
CGO_ENABLED=0 go build
docker build --rm -t mcmediacom/dns-forwarder .
