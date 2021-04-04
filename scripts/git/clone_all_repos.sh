#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR && cd ../utils
source variables.sh

# @INFRA_TODO
# @DISCUSS
#  Create a global config file and put the list of repos inside?

mkdir -p $REPOS_DIR

# React Para Trabalho
cd $REPOS_DIR
echo "--------------------------------------------"
echo "- Clonning React Para Trabalho"
git clone git@github.com:microenv/react-para-trabalho.git
mv react-para-trabalho rpt
echo "- Clonned at $REPOS_DIR/rpt"
echo "--------------------------------------------"

# Youtube Website
echo "--------------------------------------------"
echo "- Clonning React Para Trabalho"
git clone git@github.com:BrasilHomeOffice/youtube-website.git
echo "- Clonned at $REPOS_DIR/youtube-website"
echo "--------------------------------------------"
