#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

cd $TF_DIR
terraform plan -var-file="./config.tfvars"
cd $DIR
