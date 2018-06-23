#!/bin/sh
set -e

eval $(ssh-agent)
ssh-add /root/.ssh/id_rsa
ssh-add -L

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