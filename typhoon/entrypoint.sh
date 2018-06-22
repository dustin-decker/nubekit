#!/bin/sh
set -e

mkdir -p ~/.ssh
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""

TASK="$1"

if [ "$TASK" == "plan" ]
then
    /bin/terraform init
    /bin/terraform plan
elif [ "$TASK" == "apply" ]
then
    /bin/terraform init
    /bin/terraform apply -input=false -auto-approve=true
fi