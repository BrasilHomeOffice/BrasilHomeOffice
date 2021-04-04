#!/bin/bash
ENV_NAME="local"

# ---
# Define Useful Variables

UTILS_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd )"
BASE_DIR="$( cd $UTILS_DIR &> /dev/null && cd ../../ &> /dev/null && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"
INFRA_DIR="$BASE_DIR/infrastructure"
ENV_DIR="$INFRA_DIR/env/$ENV_NAME" # infrastructure/local
TF_DIR="$ENV_DIR/terraform" #infrastructure/local/terraform

REPOS_DIR="$BASE_DIR/repos"

cd $BASE_DIR
