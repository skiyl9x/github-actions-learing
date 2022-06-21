#!/bin/bash
PRIVATE_SSH_KEY="${1}"
USER=${2}
DOCKER_REMOTE_IP=${3}
REGISTRY_URL=${4}
IMAGE_NAME=${5}
TAG=${6}

echo "* Creating .env file for docker-compose"
echo "IMAGE = \"$REGISTRY_URL/$IMAGE_NAME:$TAG\"" > ../deploy/.env

echo "* Adding SSH private key"
mkdir -p ~/.ssh
echo "$PRIVATE_SSH_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

echo "* Deploying container with docker-compose"
docker-compose -H "ssh://$USER@$DOCKER_REMOTE_IP"  -f ../deploy/docker-compose.yml up --force-recreate -d

echo "* Clearing old images"
docker -H "ssh://$USER@$DOCKER_REMOTE_IP" image prune -f

echo "* Deleting SSH private key"
rm -f ~/.ssh/id_rsa