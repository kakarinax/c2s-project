ROOT_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOCKER_FILE := $(ROOT_DIR)/docker-compose.yml

.PHONY: rails c
rails c:
	docker exec -it c2s-project-web-1 rails c

.PHONY: app bash
app bash:
	docker exec -it c2s-project-web-1 bash