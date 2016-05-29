# == Class rocketchat::service
#
# This class is meant to be called from rocketchat.
# It ensure the service is running.
#
class rocketchat::service {

  service { $::rocketchat::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
