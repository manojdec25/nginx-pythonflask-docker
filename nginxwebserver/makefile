

PROJECT=pythondockerwebapp

NO_CACHE?=--no-cache --pull 
IMAGE_NAME=nginxwebserver

DOCKER_HUB_REPO=manojdec25
DOCKER_HUB_REPO_PORT=5000


.PHONY: all
all: build

clean : clean_docker

build : pre_build build_docker_tag post_build

pre_build:

build_docker:
	echo "Running docker build for $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) -f $(IMAGE_NAME)-docker .

build_docker_tag:
	echo "Running docker build for $(IMAGE_NAME)"
	docker build -t $(DOCKER_HUB_REPO)/$(PROJECT):$(IMAGE_NAME) -f $(IMAGE_NAME)-docker .
	docker push $(DOCKER_HUB_REPO)/$(PROJECT):$(IMAGE_NAME)


post_build:

clean_docker :
	echo "Cleaning ..."
	docker rmi $(IMAGE_NAME)
