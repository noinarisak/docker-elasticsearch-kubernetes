# Author: noi@uprisingtech.com 
# Date: 2019-01-11
# Desc: Makefile used for working with Docker container.

.PHONY: help build run clean rebuild

DOCKER_HUB_ACCOUNT=noinarisak
CONTAINER_NAME=docker-elasticsearch-kubernetes
CONTAINER_VERSION=6.5.4
CONTAINER=${DOCKER_HUB_ACCOUNT}/${CONTAINER_NAME}:${CONTAINER_VERSION} 

help: ## This help. Inspired by https://www.integralist.co.uk/posts/dev-environments-within-docker-containers/
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker image.
	@docker build -t ${CONTAINER} .

# run: build ## Run docker image.
# 	@docker run -it -v "$$(pwd)":/data ${CONTAINER} /bin/bash

publish: build ## Push image into Registry
	@docker push ${CONTAINER} 

clean: ## Clean docker images.
	-@docker rmi -f ${CONTAINER} &> /dev/null || true

rebuild: clean run ## Rebuild.