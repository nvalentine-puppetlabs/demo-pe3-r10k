node 'base' {
  include ntp
  ini_setting { 'set puppet agent environment':
    ensure => present,
    path => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'agent',
    setting => 'environment',
    value => 'dev',
  }
}

node /^master.*$/ inherits base {
  if $::osfamily == 'redhat' {
    class { 'firewall': ensure => stopped, }
  }

  package { 'git': ensure => present, }

  file { 'r10k environments dir':
    ensure => directory,
    path => '/etc/puppetlabs/puppet/environments',
  }
 
  class { 'r10k': 
    remote => 'git://github.com/nvalentine-puppetlabs/demo-pe3-r10k-environments',
  } 

  exec { 'r10k deploy environment --puppetfile':
    path => ['/bin','/sbin','/usr/bin','/usr/sbin','/opt/puppet/bin'],
    require => [Package['git'],File['r10k environments dir'],Class['r10k::install']],
  }

  include r10k::prerun_command
  include r10k::mcollective

  ini_setting { 'master module path':
    ensure => present,
    path => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'modulepath',
    value => '/etc/puppetlabs/puppet/environments/$environment/modules:/opt/puppet/share/puppet/modules',
  }

  ini_setting { 'master manifest path':
    ensure => present,
    path => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'manifest',
    value => '/etc/puppetlabs/puppet/environments/$environment/manifests/site.pp',
  }

  ini_setting { 'hiera path':
    ensure => present,
    path => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'heira_config',
    value => '/etc/puppetlabs/puppet/environments/$environment/hiera.yaml',
  }

  Ini_setting['set puppet agent environment'] {
    value => 'production',
  }
}

node default inherits base {
  notify { "Node ${::hostname} received default node classification!": }
}
