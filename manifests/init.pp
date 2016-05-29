# Class: rocketchat
# ===========================
#
# Full description of class rocketchat here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class rocketchat (
  $service_name  = $::rocketchat::params::service_name,
  $listen        = '127.0.0.1',
  $port          = '3000',
  $enable        = true,
  $user          = 'rocketchat',
  $group         = 'rocketchat',
  $ensure        = true,
  $manage_nodejs = false,
  $version       = 'latest',
) inherits ::rocketchat::params {

  # validate parameters here

  class { '::rocketchat::install': } ->
  class { '::rocketchat::config': } ~>
  class { '::rocketchat::service': } ->
  Class['::rocketchat']
}
