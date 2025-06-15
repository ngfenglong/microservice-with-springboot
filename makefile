version = s4make 
MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build-all: build-accounts build-configserver build-cards build-eurekaserver build-gatewayserver build-loans

build-accounts:
	cd "$(MAKEFILE_DIR)/accounts" && mvn compile jib:dockerBuild

build-configserver:
	cd $(MAKEFILE_DIR)/configserver && mvn compile jib:dockerBuild

build-cards:
	cd $(MAKEFILE_DIR)/cards && mvn compile jib:dockerBuild

build-eurekaserver:
	cd $(MAKEFILE_DIR)/eurekaserver && mvn compile jib:dockerBuild

build-gatewayserver:
	cd $(MAKEFILE_DIR)/gatewayserver && mvn compile jib:dockerBuild

build-loans:
	cd $(MAKEFILE_DIR)/loans && mvn compile jib:dockerBuild


deploy-all:
	docker push docker.io/zell1502/accounts:${version}
	docker push docker.io/zell1502/cards:${version}
	docker push docker.io/zell1502/configserver:${version}
	docker push docker.io/zell1502/eurekaserver:${version}
	docker push docker.io/zell1502/gatewayserver:${version}
	docker push docker.io/zell1502/loans:${version}

run-default:
	cd $(MAKEFILE_DIR)/docker-compose/default && docker compose up