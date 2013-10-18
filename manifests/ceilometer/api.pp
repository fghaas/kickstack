class kickstack::ceilometer::api inherits kickstack {

  include kickstack::ceilometer::config
  include pwgen

  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $service_password = pick(getvar("${fact_prefix}ceilometer_keystone_password"),pwgen())
  $sql_conn = getvar("${fact_prefix}ceilometer_sql_connection")

  class { '::ceilometer::api':
    verbose           => $kickstack::verbose,
    debug             => $kickstack::debug,
    auth_type         => 'keystone',
    auth_host         => $auth_host,
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'glance',
    keystone_password => $service_password,
    sql_connection    => $sql_conn,
    registry_host     => $reg_host,
  }

  kickstack::endpoint { 'ceilometer':
    service_password => $service_password,
    require          => Class['::ceilometer::api']
  }

}
