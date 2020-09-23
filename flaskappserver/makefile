

PROJECT=pythondockerwebapp
DOCKER_REPO_PORT=5000
NO_CACHE?=--no-cache --pull
IMAGE_NAME=flaskappserver


.PHONY: all
all: build


build: pre_build build_docker_tag post_build

clean: clean_docker

pre_build:

build_docker:
	@echo "Running docker build for $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) -f $(IMAGE_NAME)-docker .

build_docker_tag:
	@echo "Running docker build for $(IMAGE_NAME)"
	docker build -t $(DOCKER_REPO)/$(PROJECT):$(IMAGE_NAME) -f $(IMAGE_NAME)-docker .
	docker push $(DOCKER_REPO)/$(PROJECT):$(IMAGE_NAME)

post_build:

clean_docker:
	@echo "Cleaning ..."
	docker rmi $(DOCKER_REPO)/$(PROJECT):$(IMAGE_NAME)

