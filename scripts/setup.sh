#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

# @INFRA_TODO
#  Tell the user that he already have installed
#  if he executes ./setup.sh again

# ---
# Clone Repos
[ -d "$REPOS_DIR" ] || mkdir -p $REPOS_DIR
$SCRIPTS_DIR/git/clone_all_repos.sh

# -------------------------
# TERRAFORM

# ---
# Create `local/terraform/config.tfvars`
# if it does not exists.
[ -f "$TF_DIR/config.tfvars" ] \
    || cp "$TF_DIR/example.tfvars" "$TF_DIR/config.tfvars"

# ---
# Start terraform
cd $TF_DIR
terraform init -var-file="./config.tfvars"
terraform apply --auto-approve -var-file="./config.tfvars"
cd $DIR
