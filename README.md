demo-pe3-r10k
=================

Vagrant environment for demo'ing PE3 w/ r10k and current best practices for building out
self-contained environments (classification, code & data bindings) per recent Pro Services
discussions. 

The r10k setup leverages the work done in the zack/r10k Forge module. This includes a 
custom pre-run command in puppet.conf and an MCollective plug-in to allow r10k operations 
via Live Management in the Enterprise Console.

Also, the environments built out by r10k aim to be self-contained. Meaning the directories include:
  * hierdata directory
  * modules directory built out via Puppetfile
  * manifests/site.pp for classification via code

Note that this structure for self-contained environments is roughly compatible with the recent
work done by Eric Shamow and Carl Caum on Puppet Enterprise Continuous Delivery support.

# Requirements
  * VirtualBox >= 4.2
  * Vagrant >= 1.2
  * vagrant-oscar ( '$ vagrant plugin install oscar' )
  * vagrant-pe_build ( '$ vagrant plugin install vagrant-pe_build' )
  * vagrant-auto_network ( '$ vagrant plugin install vagrant-auto_network' )
  * vagrant-hosts ( '$ vagrant plugin install vagrant-hosts' )
  * librarian-puppet ( '$ sudo gem install librarian-puppet' )

# Usage
    $ cd <repo>
    $ (cd puppet && librarian-puppet install --verbose)
    $ vagrant up

# Notes
  * The vagrant environment will download the required Vagrant baseboxes if they've not already been installed. This can result in quite a long first run.
  * Login to console via: https://<master eth1 IP> w/ creds: admin@puppetlabs.com/puppetlabs.
  * r10k builds out environments in master:/etc/puppetlabs/puppet/environments based on the branches in githhub.com/nvalentine-puppetlabs/demo-pe3-r10k-environments. You can point r10k to a different repo by modifying the code in puppet/manifests/site.pp.

# Implementation details
  * There's currently a bug in the vagrant-auto_network plugin that necessitates having each VM
initially assiged the IP address 0.0.0.0. This is a temporary hack.
