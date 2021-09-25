OPENAPI_REPO = docs/unite-api-doc

.PHONY: pull-openapi
pull-openapi:
	cd $(OPENAPI_REPO); git pull origin HEAD

.PHONY: clean-local-mysql
clean-local-mysql:
	rm -rf mysql/data
	mkdir mysql/data

.PHONY: run-api-local
run-api-local:
	docker compose -f local.docker-compose.yaml up

.PHONY: run-api-local-build
run-api-local-build:
	docker compose -f local.docker-compose.yaml build --force-rm --no-cache

.PHONY: run-api-local-down
run-api-local-down:
	docker compose -f local.docker-compose.yaml down
