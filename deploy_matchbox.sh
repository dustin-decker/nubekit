#!/bin/bash

set -e

echo "deploying matchbox"
docker run -d \
    --name matchbox \
    -p 127.0.0.1:8080:8080 \
    -p 127.0.0.1:8081:8081 \
    -v `pwd`/out:/run/secrets \
    -v data:/data \
    -v assets:/assets \
    -e MATCHBOX_ADDRESS=0.0.0.0:8080 \
    -e MATCHBOX_RPC_ADDRESS=0.0.0.0:8081 \
    -e MATCHBOX_LOG_LEVEL=debug \
    quay.io/coreos/matchbox:v0.7.0 \
    -key-file /run/secrets/localhost.key \
    -cert-file /run/secrets/localhost.crt \
    -ca-file /run/secrets/matchbox.crt \
    -data-path /data \
    -assets-path /assets

echo "forwarding via ngrok"
ngrok http 8080

echo "done"