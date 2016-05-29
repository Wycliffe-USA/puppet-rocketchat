# == Class rocketchat::install
#
# This class is called from rocketchat for install.
#
class rocketchat::install {

  include ::mongodb::server

  wget::fetch { 'rocketchat source':
    source      => $::rocketchat::params::source_url,
    destination => '/tmp/rocket.chat.tgz',
    timeout     => 0,
    verbose     => false,
  } ->

  exec { 'unpack rocketchat':
    command => '/bin/tar -zxf /tmp/rocket.chat.tgz',
    creates => '/tmp/bundle/',
    } ~>

  nodejs::npm { 'rocketchat':
    ensure  => 'present',
    package => 'express',
    source  => '/tmp/bundle/programs/server',
    target  => '/opt/packages',
  }

  package { 'graphicsmagick':
    ensure => present,
  }
}
