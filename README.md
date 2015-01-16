Contrib Development Workspace
--------------------------------------------------------------

A development workspace powered by Drush, Vagrant, and Aegir 3.

# Overview

Here is an overview of the various folders and what they are
used for.

* **builds** Platforms for Aegir to import.
* **logs** Apache will write each site's logs here.
* **repository** Can be custom profiles or distributions. This is symlinked to /var/aegir/repository. Allows you to symlink these are profiles for builds.
* **shared** is a folder that is shared into Aegir's user directory.
* **tools** contains scripts for using the development workspace.

# Getting started

## Install the workspace

There is some general installation steps. We required Drush Vagrant
and Aegir Up. Just do "sh tools/install.sh" from the root directory to get setup.

### Use dnsmasq

Highly recommend using dnsmasq for local wildcard subdomains.

Add to dnsmasq.conf
````
address=/contrib.dev/10.22.22.0
````

## Creating environments

@todo: Create some fancy scripts to help setup Panopoly, Commerce Kickstart, etc.

## Creating builds

@todo: Create some fancy scripts.

## Access the VM

You can access the VM through the Drush Vagrant module.

````
// Bring up the VM
drush @contrib.project vg up

// SSH into the VM
drush @contrib.project vsh
````

# To Do
* Provide integration into the Aegir VM
  * Testing on other environment. Running hostmaster commands via Drush alias is hit or miss on provision commands.
