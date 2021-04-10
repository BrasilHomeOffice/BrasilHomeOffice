#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

sudo echo "Only sudo"

cd $TF_DIR

# Destroy
terraform destroy -var-file="./config.tfvars" --auto-approve \
  -target=docker_container.youtube-website-container
terraform destroy -var-file="./config.tfvars" --auto-approve \
  -target=docker_container.youtube-api-container
terraform destroy -var-file="./config.tfvars" --auto-approve \
  -target=docker_container.youtube-db-container
terraform destroy -var-file="./config.tfvars" --auto-approve \
  -target=docker_image.youtube-api-image
terraform destroy -var-file="./config.tfvars" --auto-approve \
  -target=docker_image.youtube-db-image

# Apply
sudo chmod -R 777 $STORAGE_DIR
terraform apply -var-file="./config.tfvars" --auto-approve
