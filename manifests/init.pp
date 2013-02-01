# Public: Install cassandra via homebrew
#
# Examples
#
#   include cassandra
class cassandra {
  include cassandra::config
  include homebrew
  include java

  file { [
    $cassandra::config::configdir,
    $cassandra::config::datadir,
    $cassandra::config::logdir
  ]:
    ensure => directory
  }

  file { "${cassandra::config::configdir}/cassandra.yml":
    content => template('cassandra/cassandra.yaml.erb'),
    notify  => Service['dev.cassandra'],
  }

  file { "${cassandra::config::configdir}/cassandra-env.sh":
    source  => 'puppet:///modules/cassandra/cassandra-env.sh',
    notify  => Service['dev.cassandra'],
  }

  file { "${cassandra::config::configdir}/log4j-server.properties":
    content => template('cassandra/log4j-server.properties.erb'),
    notify  => Service['dev.cassandra'],
  }

  homebrew::formula { 'cassandra':
    before => Package['boxen/brews/cassandra'],
  }

  package { 'boxen/brews/cassandra':
    ensure  => '1.1.7-boxen1',
    require => Class['java'],
    notify  => Service['dev.cassandra'],
  }

  file { '/Library/LaunchDaemons/dev.cassandra.plist':
    content => template('cassandra/dev.cassandra.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.cassandra'],
    owner   => 'root'
  }

  service { 'dev.cassandra':
    ensure  => running,
  }
}
