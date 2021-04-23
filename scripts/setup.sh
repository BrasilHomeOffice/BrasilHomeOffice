#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

#####################################################################
# setup.sh
#
# Starts all the containers
#
#####################################################################

if [ -f "$TF_DIR/terraform.tfstate" ]; then
  echo "You already have your environment set up"
  echo "If you want to install again, you can either"
  echo "uninstall and setup again, or:"
  echo ""
  echo "./reset-hard.sh"
  echo ""
  exit 1
fi

# TEMPORARY FIX
sudo echo "> starting setup"

# ---
# Clone Repos
[ -d "$REPOS_DIR" ] || mkdir -p $REPOS_DIR
$SCRIPTS_DIR/git/clone_all_repos.sh

# ---
# Build docker images
$DIR/build-docker-images.sh

# -------------------------
# TERRAFORM

sudo chmod -R 777 $STORAGE_DIR

# ---
# Create `local/terraform/config.tfvars`
# if it does not exists.
[ -f "$TF_DIR/config.tfvars" ] \
    || cp "$TF_DIR/example.tfvars" "$TF_DIR/config.tfvars"

# ---
# Start terraform
cd $TF_DIR
terraform init -var-file="./config.tfvars"
terraform apply -var-file="./config.tfvars" --auto-approve
cd $DIR
