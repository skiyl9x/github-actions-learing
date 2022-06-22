#!/bin/bash
PRIVATE_SSH_KEY="${1}"
USER="${2}"
DOCKER_REMOTE_IP="${3}"
REGISTRY_URL="${4}"
IMAGE_NAME="${5}"
TAG="${6}"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
CYAN='\033[0;36m'

check_result() {
    if [ $1 -ne 0 ]; then
        echo -e "${RED}[Failed]${NC}"
	echo "  - More details:"
	cat result
	echo ""
    else
	echo -e "${GREEN}[Done]${NC}"
    fi
}

stepMessage() {
    echo -e -n "- $1: "
}


stepMessage "Creating .env file for docker-compose"
(echo "IMAGE = \"$REGISTRY_URL/$IMAGE_NAME:$TAG\"" > ../deploy/.env) > result 2>&1

stepMessage "* Adding SSH private key"
( mkdir -p ~/.ssh &&
echo "$PRIVATE_SSH_KEY" > ~/.ssh/id_rsa &&
chmod 600 ~/.ssh/id_rsa ) > result 2>&1

echo "* Update known hosts"
( ssh -o StrictHostKeyChecking=no $USER@$DOCKER_REMOTE_IP : ) > result 2>&1

stepMessage "* Deploying container with docker-compose"
( docker-compose -H "ssh://$USER@$DOCKER_REMOTE_IP"  -f ../deploy/docker-compose.yml up --force-recreate -d ) > result 2>&1

stepMessage "* Clearing old images"
( docker -H "ssh://$USER@$DOCKER_REMOTE_IP" image prune -f ) > result 2>&1

stepMessage "* Deleting SSH private key"
( rm -f ~/.ssh/id_rsa ) > result 2>&1

stepMessage "* Clear known hosts"
( cat /dev/null > ~/.ssh/known_hosts ) > result 2>&1
