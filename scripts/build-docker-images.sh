#!/bin/bash

#####################################################################
# build-docker-images.sh
#
# This script builds all docker images
# Please choose the ones you want to rebuild below
#
#
# Options
#
# Build youtube-api
BUILD_API=1
# Build youtube-website
BUILD_WEBSITE=1
#####################################################################

DIR=$(dirname $0)
source $DIR/utils/variables.sh

if [ "$BUILD_API" = "1" ]; then
  echo "Build youtube-api"
  cd $ENV_DIR/youtube-website
  DOCKER_BUILDKIT=1 docker build \
    -f Dockerfile-api ../../../../ \
    -t youtube-api
  echo "youtube-api finished build"
fi

if [ "$BUILD_WEBSITE" = "1" ]; then
  echo "Build youtube-website"
  cd $ENV_DIR/youtube-website
  DOCKER_BUILDKIT=1 docker build \
    -f Dockerfile-website ../../../../ \
    -t youtube-website
  echo "youtube-website finished build"
fi
