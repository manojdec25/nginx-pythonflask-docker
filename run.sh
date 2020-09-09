#!/usr/bin/env bash

PROJECT=pythondockerwebapp
NGINX=nginxwebserver
FLASKAPP=flaskappserver

DOCKER_HUB_REPO=manojdec25
DOCKER_HUB_REPO_PORT=5000

NETWORK=docker-net

NGINX_IMAGE=$(DOCKER_HUB_REPO)/$(PROJECT):$(NGINX)
FLASKAPP_IMAGE=$(DOCKER_HUB_REPO)/$(PROJECT):$(FLASKAPP)



# Build docker image in local docker
build_docker_image() {

echo "Building $NGINX"
make -C $NGINX

echo "Building $FLASKAPP"
make -C $FLASKAPP

}


create_docker_net() {

echo "Creating docker network $NETWORK"
docker network create $NETWORK

}

deploy_docker() {

echo "Running $FLASKAPP"
docker run -d --name $FLASKAPP --net $NETWORK -v "./projectapp" $FLASKAPP
echo "Running $NGINX"
docker run -d --name $NGINX --net $NETWORK -p "80:80" $NGINX

}

deploy_docker_from_registry() {

echo "Running $FLASKAPP_IMAGE"
docker run -d --name $FLASKAPP --net $NETWORK -v "./projectapp" manojdec25/pythondockerwebapp:$FLASKAPP
echo "Running $NGINX_IMAGE"
docker run -d --name nginxwebserver --net docker-net -p "80:80" manojdec25/pythondockerwebapp:$NGINX


}


build_docker_image
create_docker_net
#deploy_docker
deploy_docker_from_registry