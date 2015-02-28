Aegir Development Workspace
--------------------------------------------------------------

A development workspace powered by Drush, Vagrant, and Aegir 3.

# Overview

Here is an overview of the various folders and what they are used for.

* **builds** Platforms for Aegir to import.
* **logs** Apache will write each site's logs here.
* **sources** Can be custom profiles or distributions. This is symlinked to /var/aegir/repository. Allows you to symlink these are profiles for builds.



# Getting started

vagrant up

### Use dnsmasq

Highly recommend using dnsmasq for local wildcard subdomains.

Add to dnsmasq.conf
````
address=/aegir.dev/10.22.22.0
````

## Creating environments

@todo: Create some fancy scripts to help setup Panopoly, Commerce Kickstart, etc.

# Credit/Thanks

I borrowed/copied items from all of the below awesome open source projects which made this possible and taught me a little bit about Puppet.

* [Puppet Aegir](https://www.drupal.org/project/puppet_aegir)
* [Puppet Drush](https://www.drupal.org/project/puppet_drush)
* [Drush Vagrant](https://www.drupal.org/project/drush-vagrant)
* [PuPHPet](https://puphpet.com/)
