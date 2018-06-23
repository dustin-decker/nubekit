FROM alpine:latest

ENV TERRAFORM_VERSION=0.11.7

RUN apk add --no-cache git openssh openssh-client && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN wget https://github.com/coreos/terraform-provider-matchbox/releases/download/v0.2.2/terraform-provider-matchbox-v0.2.2-linux-amd64.tar.gz && \
    tar xzf terraform-provider-matchbox-v0.2.2-linux-amd64.tar.gz && \
    mv terraform-provider-matchbox-v0.2.2-linux-amd64/terraform-provider-matchbox /usr/local/bin/

COPY typhoon/entrypoint.sh /entrypoint.sh
COPY typhoon/.terraformrc /root/.terraformrc
WORKDIR /infra/clusters

ENTRYPOINT ["/entrypoint.sh"]