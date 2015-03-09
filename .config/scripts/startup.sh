#!/bin/sh
# Need this because Apache is running on boot, methinks.
sudo apachectl graceful

# Setup symlink for Aegir module development...
if [ -d "/vagrant/aegir-dev/modules" ]; then
	ln -s /vagrant/aegir-dev/modules /var/aegir/hostmaster/sites/all/modules/dev
fi

# Setup symlink for Aegir theme development...
if [ -d "/vagrant/aegir-dev/themes" ]; then
	ln -s /vargrant/aegir-dev/themes /var/aegir/hostmaster/sites/all/themes/dev
fi

if [ -d "/vargrant/aegir-dev/drush" ]; then
	ln -s /vagrant/aegir-dev/drush /var/aegir/.drush/dev
fi
