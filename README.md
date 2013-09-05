dev-puppet-module
=================

Vagrant environment for demo'ing PE3 w/ r10k.

# Requirements
  * VirtualBox 1.4.x
  * Vagrant 1.2
  * vagrant-pe_build ( '$ vagrant plugin install vagrant-pe_build' )
  * vagrant-auto_network ( '$ vagrant plugin install vagrant-auto_network' )
  * vagrant-hosts ( '$ vagrant plugin install vagrant-hosts' )
  * librarian-puppet ( '$ sudo gem install librarian-puppet' )

# Usage
    $ cd <repo>/.cache && wget \
       -c http://s3.amazonaws.com/pe-builds/released/3.0.1/puppet-enterprise-3.0.1-ubuntu-12.04-amd64.tar.gz
    $ vagrant up
