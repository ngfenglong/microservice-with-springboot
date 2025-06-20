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


docker-up:
	cd $(MAKEFILE_DIR)/docker-compose/default && docker compose up

docker-down:
	cd $(MAKEFILE_DIR)/docker-compose/default && docker compose down

################################################################################
# KUBERNETES SECTION
################################################################################


KUBE_DIR := $(MAKEFILE_DIR)/kubernetes

# Individual apply commands
kube-keycloak:
	kubectl apply -f $(KUBE_DIR)/1_keycloak.yml

kube-configmap:
	kubectl apply -f $(KUBE_DIR)/2_configmaps.yaml

kube-configserver:
	kubectl apply -f $(KUBE_DIR)/3_configserver.yml

kube-eurekaserver:
	kubectl apply -f $(KUBE_DIR)/4_eurekaserver.yml

kube-accounts:
	kubectl apply -f $(KUBE_DIR)/5_accounts.yml

kube-loans:
	kubectl apply -f $(KUBE_DIR)/6_loans.yml

kube-cards:
	kubectl apply -f $(KUBE_DIR)/7_cards.yml

kube-gateway:
	kubectl apply -f $(KUBE_DIR)/8_gateway.yml

kube-message:
	kubectl apply -f $(KUBE_DIR)/9_message.yml

# Apply all
kube-up: kube-keycloak kube-configmap kube-configserver kube-eurekaserver kube-accounts kube-loans kube-cards kube-gateway kube-message


# Delete all
kube-down:
	kubectl delete -f $(KUBE_DIR)/9_message.yml
	kubectl delete -f $(KUBE_DIR)/8_gateway.yml
	kubectl delete -f $(KUBE_DIR)/7_cards.yml
	kubectl delete -f $(KUBE_DIR)/6_loans.yml
	kubectl delete -f $(KUBE_DIR)/5_accounts.yml
	kubectl delete -f $(KUBE_DIR)/4_eurekaserver.yml
	kubectl delete -f $(KUBE_DIR)/3_configserver.yml
	kubectl delete -f $(KUBE_DIR)/2_configmaps.yaml
	kubectl delete -f $(KUBE_DIR)/1_keycloak.yml

