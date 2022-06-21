#!/bin/bash
PRIVATE_SSH_KEY="${1}"
USER=${2}
DOCKER_REMOTE_IP=${3}
REGISTRY_URL=${4}
IMAGE_NAME=${5}
TAG=${6}

echo "IMAGE = \"$REGISTRY_URL/$IMAGE_NAME:$TAG\"" > ../deploy/.env
mkdir -p ~/.ssh
echo "$PRIVATE_SSH_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
docker-compose -H "ssh://$USER@$DOCKER_REMOTE_IP" -f ../deploy/docker-compose.yml up -d
rm -f ~/.ssh/id_rsa