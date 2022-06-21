#!/bin/bash

# DOCKER_REMOTE_IP=${1}
# TOKEN=${2}

# echo  $TOKEN   |  docker --host tcp://$DOCKER_REMOTE_IP:2375 --tlsverify --tlscacert "ca.pem" --tlscert "client-cert.pem" --tlskey "client-key.pem" login ghcr.io -u skiyl9x --password-stdin
# docker-compose --host tcp://$DOCKER_REMOTE_IP:2375 --tlsverify --tlscacert "ca.pem" --tlscert "client-cert.pem" --tlskey "client-key.pem" -f ../deploy/docker-compose.yml 

# docker context create my-context --description "some description" --docker "host=tcp://$DOCKER_REMOTE_IP:2375,ca=./ca.pem,cert=./client-cert.pem,key=./client-key.pem"
# docker context use my-context
# echo  $TOKEN   |  docker login ghcr.io -u skiyl9x --password-stdin
# docker-compose -f ../deploy/docker-compose.yml down
# docker-compose -f ../deploy/docker-compose.yml rm --all
# docker-compose -f ../deploy/docker-compose.yml  up -d 
# cat ../deploy/.env

PRIVATE_SSH_KEY=${1}
USER=${2}
DOCKER_REMOTE_IP=${3}
REGISTRY_URL=${4}
IMAGE_NAME=${5}
TAG=${6}

whoami
echo "IMAGE = \"$REGISTRY_URL/$IMAGE_NAME:$TAG\"" > ../deploy/.env
echo "$PRIVATE_SSH_KEY" > ~/.ssh/id_rsa
docker-compose -H "ssh://$USER@$DOCKER_REMOTE_IP" -f ../deploy/docker-compose.yml up -d