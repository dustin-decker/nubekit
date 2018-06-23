# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

TAG=$(shell git describe --tags --abbrev=0 2>/dev/null)
SHA=$(shell git describe --match=NeVeRmAtCh --always --abbrev=7 --dirty)

ifeq ($(TAG),)
	VERSION=$(SHA)
else
	VERSION=$(TAG)-$(SHA)
endif

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build-typhoon: ## build typhoon + terraform for applying config to matchbox
	./scripts/build_typhoon.sh

build-ipxe: ## build iPXE ISO for booting from matchbox
	./scripts/build_ipxe.sh

deploy-matchbox: ## deploy matchbox server for iPXE booting
	./scripts/deploy_matchbox.sh

apply-typhoon: ## apply typhoon config to matchbox using terraform
	./scripts/apply_typhoon.sh

gen-secrets: ## generate TLS secrets needed to make a secure K8s cluster
	./scripts/gen_secrets.sh