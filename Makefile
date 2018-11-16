.DEFAULT_GOAL := help

DOCKER_TAG ?= latest

.PHONY: docker # Build docker image
docker:
	@docker build -t hendrikmaus/message-server:$(DOCKER_TAG) .
	@docker tag hendrikmaus/message-server:$(DOCKER_TAG) hendrikmaus/message-server:latest

.PHONY: build # Build for current platform
build:
	@go build -o message-server

.PHONY: run # Run locally
run:
	@go run main.go

.PHONY: push # Push to dockerhub
push:
	@docker push hendrikmaus/message-server:$(DOCKER_TAG)
	@docker push hendrikmaus/message-server:latest

.PHONY: clean # Clean
clean:
	@rm ./message-server

.PHONY: publish # Build, containerize and push
publish: docker push

.PHONY: help # Print help screen
help:
	@echo "message-server make help"
	@echo "\n\033[0;33mTargets:"
	@grep -E '^\.PHONY: .* #' makefile | sed -E 's/^\.PHONY: (.*) # (.*)/"\1" "\2"/g' | xargs printf "  \033[0;32m%-20s \033[0;0m%s\n"
