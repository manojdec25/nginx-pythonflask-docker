#!/usr/bin/env bash

PROJECT=pythondockerwebapp
NGINX=nginxwebserver
FLASKAPP=flaskappserver
DOCKER_REPO_PORT=5000
NETWORK=docker-net


while getopts r:n: option
do
case "${option}"
in
r) DOCKER_REPO=${OPTARG};;
n) NETWORK=${OPTARG};;
esac
done

echo "Repo is $DOCKER_REPO"
echo "Network is $NETWORK"

NGINX_IMAGE="$DOCKER_REPO/$PROJECT:$NGINX"
FLASKAPP_IMAGE="$DOCKER_REPO/$PROJECT:$FLASKAPP"
echo "NGINX_IMAGE is $NGINX_IMAGE"
echo "FLASKAPP_IMAGE is $FLASKAPP_IMAGE"


# Build docker image in local docker
build_docker_image() {

echo "Building $NGINX"
make DOCKER_REPO=$DOCKER_REPO -C $NGINX


echo "Building $FLASKAPP"
make DOCKER_REPO=$DOCKER_REPO -C $FLASKAPP


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
docker run -d --name $FLASKAPP --net $NETWORK -v "./projectapp" $DOCKER_REPO/pythondockerwebapp:$FLASKAPP
echo "Running $NGINX_IMAGE"
docker run -d --name nginxwebserver --net docker-net -p "80:80" $DOCKER_REPO/pythondockerwebapp:$NGINX

}


build_docker_image
create_docker_net
#deploy_docker
deploy_docker_from_registry