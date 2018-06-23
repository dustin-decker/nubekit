#!/bin/bash

set -e

echo "building ipxe image"
docker build --build-arg 'MATCHBOX=http://matchbox.ngrok.io.ngrok.io' -t ipxe -f ipxe.Dockerfile .
docker run -d --name temp-ipxe ipxe
docker cp temp-ipxe:/usr/share/nginx/html/matchbox.iso out/matchbox.iso
docker rm -f temp-ipxe
echo "done"
