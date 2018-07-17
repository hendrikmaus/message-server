.DEFAULT_GOAL := help

DOCKER_TAG ?= latest

.PHONY: build-linux # Build for linux and containerize
build-linux:
	@GOOS=linux GOARCH=amd64 go build \
	&& docker build -t hendrikmaus/message-server:$(DOCKER_TAG) .

.PHONY: build # Build for current platform
build:
	go build

.PHONY: run # Run locally
run:
	go run main.go

.PHONY: push # Push to dockerhub
push:
	@docker push hendrikmaus/message-server:$(DOCKER_TAG)

.PHONY: clean # Clean
clean:
	rm ./message-server

.PHONY: publish # Build, containerize and push
publish: build-linux push clean

.PHONY: help # Print help screen
help:
	@echo "message-server make help"
	@echo "\n\033[0;33mTargets:"
	@grep -E '^\.PHONY: .* #' makefile | sed -E 's/^\.PHONY: (.*) # (.*)/"\1" "\2"/g' | xargs printf "  \033[0;32m%-20s \033[0;0m%s\n"
