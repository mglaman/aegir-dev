#!/bin/sh

# Define root of project.
cd ${0%/*}
ROOT=$(dirname $(pwd))
cd ${ROOT}

cat .config/conrib.aliases.drushrc.php | sed  "s|CONTRIBENVPATH|${ROOT}|" > $HOME/.drush/contrib.aliases.drushrc.php

drush cc drush
