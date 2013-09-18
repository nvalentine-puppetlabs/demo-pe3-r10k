demo-pe3-r10k
=================

Vagrant environment for demo'ing PE3 w/ r10k and current best practices for building out
self-contained environments (classification, code & data bindings) per recent Pro Services
discussions. 

The r10k setup leverages the work done in the
zack/r10k Forge module. This includes a custom pre-run command in puppet.conf and an MCollective
plug-in to allow r10k operations via Live Management in the Enterprise Console.

Also, the environments built out by r10k aim to be self-contained. Meaning the directories include:
  * hierdata directory
  * modules directory built out via Puppetfile
  * manifests/site.pp for classification via code

Note that this structure for self-contained environments is roughly compatible with the recent
work done by Eric Shamow and Carl Caum on Puppet Enterprise Continuous Delivery support.

# Requirements
  * VirtualBox >= 4.2
  * Vagrant >= 1.2
  * vagrant-pe_build ( '$ vagrant plugin install vagrant-pe_build' )
  * vagrant-auto_network ( '$ vagrant plugin install vagrant-auto_network' )
  * vagrant-hosts ( '$ vagrant plugin install vagrant-hosts' )
  * librarian-puppet ( '$ sudo gem install librarian-puppet' )

# Usage
    $ cd <repo>
    $ (cd puppet && librarian-puppet install --verbose)
    $ cd .cache
    $ wget -c http://s3.amazonaws.com/pe-builds/released/3.0.1/puppet-enterprise-3.0.1-ubuntu-12.04-amd64.tar.gz
    $ wget -c https://s3.amazonaws.com/pe-builds/released/3.0.1/puppet-enterprise-3.0.1-el-6-x86_64.tar.gz
    $ vagrant up

# Notes
  * Login to console via: https://localhost:8443 w/ creds: admin@puppetlabs.com/puppetlabs.
  * r10k builds out environments in master:/etc/puppetlabs/puppet/environments based on the branches in githhub.com/nvalentine-puppetlabs/demo-pe3-r10k-environments. You can point r10k to a different repo by modifying the code in puppet/manifests/site.pp.
  * The Puppetfile currently pulls in nvalentine-puppetlabs/r10k which has an open PR against acidprime/r10k which adds anchors to the base class r10k.

# Implementation details
  * There's currently a bug in the vagrant-auto_network plugin that necessitates having each VM
initially assiged the IP address 0.0.0.0. This is a temporary hack
