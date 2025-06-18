version = s4
MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))


################################################################################
# BUILD SECTION
################################################################################

build-all: build-accounts build-configserver build-cards build-eurekaserver build-gatewayserver build-loans build-message

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

build-message:
	cd $(MAKEFILE_DIR)/message && mvn compile jib:dockerBuild



################################################################################
# DEPLOY SECTION
################################################################################

deploy-all: deploy-accounts deploy-cards deploy-configserver deploy-eurekaserver deploy-gatewayserver deploy-loans deploy-message

deploy-accounts:
	docker push docker.io/zell1502/accounts:${version}

deploy-cards:
	docker push docker.io/zell1502/cards:${version}

deploy-configserver:
	docker push docker.io/zell1502/configserver:${version}

deploy-eurekaserver:
	docker push docker.io/zell1502/eurekaserver:${version}

deploy-gatewayserver:
	docker push docker.io/zell1502/gatewayserver:${version}

deploy-loans:
	docker push docker.io/zell1502/loans:${version}

deploy-message:
	docker push docker.io/zell1502/message:${version}

################################################################################
# DOCKER COMPOSE SECTION
################################################################################


run-default:
	cd $(MAKEFILE_DIR)/docker-compose/default && docker compose up

remove-default:
	cd $(MAKEFILE_DIR)/docker-compose/default && docker compose down
