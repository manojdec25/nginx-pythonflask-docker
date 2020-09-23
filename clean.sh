#!/usr/bin/env bash


PROJECT=pythondockerwebapp
NGINX=nginxwebserver
FLASKAPP=flaskappserver
NETWORK=docker-net

while getopts r:n: option
do
case "${option}"
in
r) DOCKER_REPO=${OPTARG};;
n) NETWORK=${OPTARG};;
esac
done


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
make DOCKER_REPO=$DOCKER_REPO -C $FLASKAPP clean

echo "Cleaning $NGINX"
make DOCKER_REPO=$DOCKER_REPO  -C $NGINX clean

}

delete_docker_net() {

echo "Deleting docker network $NETWORK"
docker network rm $NETWORK

}

kill_and_remove_docker_container
clean_docker_image
delete_docker_net
