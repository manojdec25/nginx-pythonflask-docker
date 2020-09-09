#!/usr/bin/env bash


PROJECT=pythondockerwebapp
NGINX=nginxwebserver
FLASKAPP=flaskappserver

DOCKER_HUB_REPO=manojdec25/kaldocker
DOCKER_HUB_REPO_PORT=5000

NETWORK=docker-net


kill_and_remove_docker_container() {

echo "Killing $NGINX"
docker kill $NGINX
docker rm $NGINX

echo "Killing $FLASKAPP"
docker kill $FLASKAPP
docker rm $FLASKAPP

}

clean_docker_image() {

echo "Building $FLASKAPP"
make -C $FLASKAPP clean

echo "Cleaning $NGINX"
make -C $NGINX clean

}

delete_docker_net() {

echo "Deleting docker network $NETWORK"
docker network rm $NETWORK

}

kill_and_remove_docker_container
clean_docker_image
delete_docker_net
