#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

cd $TF_DIR
terraform apply -var-file="./config.tfvars" --auto-approve
cd $DIR
