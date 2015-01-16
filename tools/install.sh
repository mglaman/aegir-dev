#!/bin/sh

###################################################
#
# Prepares the development workspace.
#
###################################################

set -e

# Define root of project.
cd ${0%/*}
ROOT=$(dirname $(pwd))
cd ${ROOT}

cd $HOME/.drush/
# Download require Drush modules
if [ ! -d "drush-vagrant" ]; then
    echo "Cloning drush-vagrant"
    git clone --branch 7.x-2.x http://git.drupal.org/project/drush-vagrant.git
fi
if [ ! -d "aegir-up" ]; then
    echo "Cloning aegir-up"
    git clone --branch 7.x-2.x http://git.drupal.org/project/aegir-up.git
fi
cd ${ROOT

drush cc drush

drush @contrib.project vg up
