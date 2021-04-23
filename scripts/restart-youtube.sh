#!/bin/bash

#####################################################################
# restart-youtube.sh
#
# This script restart the repos described below.
# Its useful when you install some dependency.
#
# youtube-website
#   https://vlog.local.brasilhomeoffice.com
# youtube-api
#   https://api-vlog.local.brasilhomeoffice.com
# youtube-db
#   -
#
# @NOTE
#   youtube-api and youtube-db are deprecated
#   a new server is being developed using
#   another technologies.
#
#
# ---
# OPTIONS
#
# RESET_WEBSITE
#   resets the website container
RESET_WEBSITE=1
# RESET_API
#   resets the api container
RESET_API=0
# RESET_DB
#   resets the db container
RESET_DB=0
#
#####################################################################

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

# This sudo is necessary because
# we need to fix docker permissions
# for the database
# Its a temporary hotfix
# We will stop using mariadb and use
# dynamodb instead, so this line
# should not exist anymore
sudo echo "> Starting script"

cd $TF_DIR
CONFIG_FILE_PATH="./config.tfvars"

# Check if config file exists
if [ ! -f "$CONFIG_FILE_PATH" ]; then
  echo "> ERROR: Config file not found"
  echo "> ERROR: Aborted"
  echo "> "
  echo "> Did you forget to run ./setup.sh ?"
  exit 1
fi

# Destroy

DESTROYED_SOME_CONTAINER=0

if [ "$RESET_WEBSITE" = "1" ]; then
  DESTROYED_SOME_CONTAINER=1
  echo "> Destroying Website"
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_image.youtube-website-image
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_container.youtube-website-container
  echo "> Website destroyed"
fi

if [ "$RESET_API" = "1" ]; then
  DESTROYED_SOME_CONTAINER=1
  echo "> Destroying API"
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_image.youtube-api-image
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_container.youtube-api-container
  echo "> API destroyed"
fi


if [ "$RESET_DB" = "1" ]; then
  DESTROYED_SOME_CONTAINER=1
  echo "> Destroying Database"
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_container.youtube-db-container
  terraform destroy -var-file="$CONFIG_FILE_PATH" --auto-approve \
    -target=docker_image.youtube-db-image
  echo "> Database destroyed"
fi

if [ "$DESTROYED_SOME_CONTAINER" = "0" ]; then
  echo "> No containers were destroyed!"
  echo "> Please open the restart-youtube.sh file"
  echo "> And edit the options manually"
  echo ">"
  echo "> @TODO ~ create a new restart script which"
  echo "> gives options to the user"
else
  echo "> Building docker images"
  $DIR/build-docker-images.sh
  echo "> Recreating the destroyed containers"
  # Recreate the services
  sudo chmod -R 777 $STORAGE_DIR
  terraform apply -var-file="$CONFIG_FILE_PATH" --auto-approve
fi
