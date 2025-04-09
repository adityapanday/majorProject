#!/bin/bash

# Load environment variables
source .env

if [ -z "$1" ]; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
else
  BRANCH=$1
fi

IMAGE_NAME="major"
# BRANCH=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}


if [ "$BRANCH" == "dev" ]; then
  TAG="dev"
  REPO="$DOCKER_USERNAME/majordev"
elif [ "$BRANCH" == "master" ]; then
  TAG="prod"
  REPO="$DOCKER_USERNAME/majorprod"
else
  echo " Unknown branch: $BRANCH"
  exit 1
fi

echo " Building Docker image: $REPO:$TAG"
docker build -t $REPO:$TAG .

echo " Logging into Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo " Pushing image to Docker Hub: $REPO:$TAG"
docker push $REPO:$TAG

echo " Image pushed successfully!"

