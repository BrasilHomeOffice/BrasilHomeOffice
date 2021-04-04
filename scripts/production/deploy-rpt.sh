#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR && cd ../utils
source variables.sh

[ -d "$REPOS_DIR/rpt" ] \
  || (echo "directory does not exists: $REPOS_DIR/rpt" && exit 123)

cd $REPOS_DIR/rpt

# @INFRA_TODO
#  Block deploy if some git file have changed
git status

up
