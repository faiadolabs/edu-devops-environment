#!/bin/bash

OS := $(shell uname)
UID = $(shell id -u)

help: ## Show this help message
	@echo
	@echo '-------------------------------------------------'
	@echo 'Entorno CI/CD EDU 👩‍🏫 👨‍🏫 🖍 📝 '
	@echo '-------------------------------------------------'
	@echo
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'
	@echo

jenkins-run: ## Start the deployments containers PRODUCTION JENKINS VERSION (Detached)
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose.yml up -d
	@echo
	@echo '-------------------------------------------------'
	@echo 'Conéctate a Jenkins en http://localhost:8080'
	@echo '-------------------------------------------------'
	@echo
	@echo 'Aguarda unos instantes antes de que el servicio se inicie... ⏱'
	@echo

jenkins-stop: ## Stop PRODUCTION JENKINS VERSION
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose.yml down

jenkins-build: ## Build DEMO JENKINS VERSION
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose.yml build

jenkins-upgrade: ## Pull last image jenkins (need rebuild)
	@echo
	docker pull jenkins/jenkins:lts-alpine

jenkins-sandbox-run: ## Start the deployments containers DEMO JENKINS VERSION (Detached)
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose-sandbox.yml up -d
	@echo
	@echo '-------------------------------------------------'
	@echo 'Conéctate a Jenkins en http://localhost:9001'
	@echo '-------------------------------------------------'
	@echo
	@echo 'Aguarda unos instantes antes de que el servicio se inicie... ⏱'
	@echo

jenkins-sandbox-stop: ## Stop DEMO JENKINS VERSION
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose-sandbox.yml down

jenkins-sandbox-build: ## Build DEMO JENKINS VERSION
	@echo
	U_ID=${UID} docker-compose -f jenkins/docker-compose-sandbox.yml build