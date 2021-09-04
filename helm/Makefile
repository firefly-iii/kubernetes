SHELL := /bin/bash

# >>> run this first when changing helm chart <<<
# creates namespaces and packages chart
default:
	@echo "Creating new package"
	helm package .
	@echo "creating debug namespace if not exists"
	kubectl create namespace debug --dry-run=client -o yaml | kubectl apply -f -
	@echo "creating dryrun namespace if not exists"
	kubectl create namespace dryrun --dry-run=client -o yaml | kubectl apply -f -
	@echo "creating firefly namespace if not exists"
	kubectl create namespace firefly --dry-run=client -o yaml | kubectl apply -f -
	@echo "Done"

# >>> to test integrety of chart <<<
.PHONY: dryRun
dryRun:
	@CANDIDATE="$(shell ls -d -- *.tgz |sort -n|tail -n 1)"; \
	echo "making dry run for $${CANDIDATE}"; \
	helm install --dry-run --debug firefly-dry $${CANDIDATE} --namespace=dryrun;

# >>> DEBUG <<<
.PHONY: installDebug
installDebug:
	@CANDIDATE="$(shell ls -d -- *.tgz |sort -n|tail -n 1)"; \
	echo "installing $${CANDIDATE}"; \
	helm install firefly-debug $${CANDIDATE} -f debug.local.values.yaml --namespace=debug;
	@echo "Done"

.PHONY: upgradeDebug
upgradeDebug:
	@CANDIDATE="$(shell ls -d -- *.tgz |sort -n|tail -n 1)"; \
	echo "upgrading $${CANDIDATE}"; \
	helm upgrade firefly-debug $${CANDIDATE} -f debug.local.values.yaml --namespace=debug;
	@echo "Done"

.PHONY: teardownDebug
teardownDebug:
	@echo "Deleting firefly"
	helm delete firefly-debug --namespace=debug
	@echo "Done"

# >>> PROD <<<
.PHONY: install
install:
	@CANDIDATE="$(shell ls -d -- *.tgz |sort -n|tail -n 1)"; \
	echo "installing $${CANDIDATE}"; \
	helm install firefly $${CANDIDATE} -f my.local.values.yaml --namespace=firefly;
	@echo "Done"

.PHONY: upgrade
upgrade:
	@CANDIDATE="$(shell ls -d -- *.tgz |sort -n|tail -n 1)"; \
	echo "upgrading $${CANDIDATE}"; \
	helm upgrade firefly $${CANDIDATE} -f my.local.values.yaml --namespace=firefly;
	@echo "Done"

# >>> DELETE PROD <<<
.PHONY: teardown
teardown:
	@echo "Deleting firefly"
	helm delete firefly --namespace=firefly
	@echo "Done"
