#!/bin/bash

echo "building typhoon terraform image"
docker build -t typhoon-terraform -f typhoon.Dockerfile .

echo "done"
