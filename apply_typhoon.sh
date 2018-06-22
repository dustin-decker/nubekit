#!/bin/bash

echo "applying typhoon"
docker run -it \
    --net=host \
    -v `pwd`/out:/run/secrets \
    -v `pwd`/typhoon/infra:/infra \
    -v tfstate:/tfstate \
    typhoon-terraform apply