#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR && cd ../utils
source variables.sh

# React Para Trabalho
cd $REPOS_DIR
echo "--------------------------------------------"
echo "- Clonning React Para Trabalho"
git clone git@github.com:microenv/react-para-trabalho.git
mv react-para-trabalho rpt
echo "- Clonned at $REPOS_DIR/rpt"
echo "--------------------------------------------"
