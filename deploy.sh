#!/bin/bash

source .env

BRANCH=$1;

# BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH" == "dev" ]; then
  TAG="dev"
  REPO="$DOCKER_USERNAME/majordev"
elif [ "$BRANCH" == "master" ]; then
  TAG="prod"
  REPO="$DOCKER_USERNAME/majorprod"
else
  echo "wrong  branch: $BRANCH"
  exit 1
fi

echo " Logging into Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo " Pulling image: $REPO:$TAG"
docker pull $REPO:$TAG

echo " Cleaning up old container..."
docker rm -f guvi-container || true

echo "running new container on port  80 "
docker run -d --name guvi-container -p 80:3000 $REPO:$TAG

echo " App deployed on http://3.7.241.240:80"


