#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/utils/variables.sh

FLAG_REMOVE_LOCAL_CONFIG=1
FLAG_REMOVE_REPOS=1

# ---
# Destroy terraform
cd $TF_DIR
VAR_FILE_PATH="./config.tfvars"
# if config.tfvars does not exists, then get example.tfvars instead
[ -f $VAR_FILE_PATH ] || VAR_FILE_PATH="./example.tfvars"
# ---
# @BUG
#  if some variable is created inside example.tfvars
#  and config.tfvars doesn't have them.
#  the code will break here
#  this is why we need `timeout 10s <command>`
# ---
# @INFRA_TODO
#  remove timeout and add an extra step here to solve this
timeout 10s \
terraform destroy -var-file=$VAR_FILE_PATH --auto-approve &> /dev/null

# Remove terraform files
rm -rf $TF_DIR/.terraform $TF_DIR/.terraform.lock.hcl $TF_DIR/terraform.tfstate $TF_DIR/terraform.tfstate.backup

# ---
# Remove docker network manually
#   if somehow it haven't been deleted before
#   it happened before, I don't know why
docker network rm brasilhomeoffice &> /dev/null

# ---
# Remove repos
if [[ $FLAG_REMOVE_REPOS == "1" ]]; then
  rm -rf $REPOS_DIR
  mkdir -p $REPOS_DIR
fi

# ---
# Remove local config files
if [[ $FLAG_REMOVE_LOCAL_CONFIG == "1" ]]; then
  rm -f $TF_DIR/config.tfvars
fi

# ---
# Display message
echo "Uninstall finished!"
echo ""
echo "----------------------------------------"
echo "- Custom Hosts"
echo "- "
echo "-   Please remove the changes you made"
echo "-   in your hosts file."
echo "- "
echo "- more info: docs/required-hosts.md"
echo "----------------------------------------"
