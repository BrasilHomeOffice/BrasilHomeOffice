#!/bin/bash

#####################################################################
# reset-hard.sh
#
# This script resets all your environment
# and you have a fresh and updated
# installation of your local env
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ATTENTION:
#  YOU WILL LOSE ALL YOUR CHANGES
#  USE THIS CAREFULLY
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
#####################################################################

./uninstall.sh --complete
./setup.sh
