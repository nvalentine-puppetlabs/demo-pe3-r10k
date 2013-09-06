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
  class { 'firewall': ensure => stopped, }

  file { '/usr/local/bin/r10k':
    ensure => link,
    target => '/opt/puppet/bin/r10k',
  }

  package { 'git': ensure => present, }

  file { 'r10k environments dir':
    ensure => directory,
    path => '/etc/puppetlabs/puppet/environments',
  }
  
  class { 'r10k': 
    remote => 'git://github.com/nvalentine-puppetlabs/demo-pe3-r10k-environments',
  } -> exec { '/opt/puppet/bin/r10k sync': 
    path => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    require => [Package['git'],File['r10k environment dir']],
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
