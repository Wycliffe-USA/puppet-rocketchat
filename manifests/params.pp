# == Class rocketchat::params
#
# This class is meant to be called from rocketchat.
# It sets variables according to platform.
#
class rocketchat::params {

  $service_name       = 'rocketchat'
  $service_hasrestart = true
  $service_hasstatus  = true
  $service_pattern    = $service_name
  $pid_dir            = '/var/run/rocketchat'

  case $::osfamily {
    'Debian': {
      $defaults_location  = '/etc/default'
    }
    'RedHat': {
      $defaults_location  = '/etc/sysconfig'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  case $::operatingsystem {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'OracleLinux', 'SLC': {

      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        $init_template        = 'rocketchat.systemd.erb'
        $service_providers    = 'systemd'
        $systemd_service_path = '/lib/systemd/system'
        } else {
          $init_template        = 'rocketchat.RedHat.erb'
          $service_providers    = 'init'
          $systemd_service_path = undef
        }
    }
    'Ubuntu': {
      if versioncmp($::operatingsystemmajrelease, '15.04') >= 0 {
        $init_template        = 'rocketchat.systemd.erb'
        $service_providers    = 'systemd'
        $systemd_service_path = '/lib/systemd/system'
        } else {
          $init_template        = 'rocketchat.Debian.erb'
          $service_providers    = 'init'
          $systemd_service_path = undef
        }
    }
    'Debian': {
      if versioncmp($::operatingsystemmajrelease, '8') >= 0 {
        $init_template        = 'rocketchat.systemd.erb'
        $service_providers    = 'systemd'
        $systemd_service_path = '/lib/systemd/system'
        } else {
          $init_template        = 'rocketchat.Debian.erb'
          $service_providers    = 'init'
          $systemd_service_path = undef
        }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
