#!/bin/bash

set -e

echo "getting certstrap"
go get -u github.com/square/certstrap

echo "generating certs"
echo "CA"
certstrap init --common-name "matchbox"
echo "Matchbox gRPC and typhoon"
certstrap request-cert --common-name "localhost"
certstrap sign "localhost" --CA "matchbox"

echo "done"