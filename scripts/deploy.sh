#!/bin/bash

DOCKER_REMOTE_IP=${1}
TOKEN=${2}

echo "IMAGE_NAME=ghcr.io/skiyl9x/github-actions-learing:dev" > ../deploy/.env
# echo  $TOKEN   |  docker --host tcp://$DOCKER_REMOTE_IP:2375 --tlsverify --tlscacert "ca.pem" --tlscert "client-cert.pem" --tlskey "client-key.pem" login ghcr.io -u skiyl9x --password-stdin
# docker-compose --host tcp://$DOCKER_REMOTE_IP:2375 --tlsverify --tlscacert "ca.pem" --tlscert "client-cert.pem" --tlskey "client-key.pem" -f ../deploy/docker-compose.yml 

docker context create my-context --description "some description" --docker "host=tcp://$DOCKER_REMOTE_IP:2375,ca=./ca.pem,cert=./client-cert.pem,key=./client-key.pem"
docker context use my-context
docker-compose up -f ../deploy/docker-compose.yml -d