#!/bin/bash

/opt/puppet/bin/puppet apply --verbose --modulepath=/vagrant/puppet/modules /vagrant/puppet/manifests/site.pp --noop && \
/opt/puppet/bin/puppet apply --verbose --modulepath=/vagrant/puppet/modules /vagrant/puppet/manifests/site.pp --debug
