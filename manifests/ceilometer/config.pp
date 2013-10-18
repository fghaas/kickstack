class kickstack::ceilometer::config inherits kickstack {

  $sql_conn = getvar("${fact_prefix}ceilometer_sql_connection")

  case "$::kickstack::rpc" {
    'rabbitmq': {
      $rabbit_host = getvar("${::kickstack::fact_prefix}rabbit_host")
      $rabbit_password = getvar("${fact_prefix}rabbit_password")
      class { '::ceilometer':
        package_ensure  => $::kickstack::package_version,
        rpc_backend     => 'ceilometer.openstack.common.rpc.impl_kombu',
        rabbit_host     => $rabbit_host,
        rabbit_password => $rabbit_password,
        rabbit_virtualhost => $::kickstack::rabbit_virtual_host,
        rabbit_userid   => $::kickstack::rabbit_userid,
        verbose         => $::kickstack::verbose,
        debug           => $::kickstack::debug,
      }
    }
    'qpid': {
      $qpid_hostname = getvar("${::kickstack::fact_prefix}qpid_hostname")
      $qpid_password = getvar("${fact_prefix}qpid_password")
      class { '::ceilometer':
        package_ensure  => $::kickstack::package_version,
        rpc_backend     => 'ceilometer.openstack.common.rpc.impl_qpid',
        qpid_hostname   => $qpid_hostname,
        qpid_password   => $qpid_password,
        qpid_realm      => $::kickstack::qpid_realm,
        qpid_user       => $::kickstack::qpid_user,
        verbose         => $::kickstack::verbose,
        debug           => $::kickstack::debug,
      }
    }
  } 
}
