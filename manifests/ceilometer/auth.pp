class kickstack::ceilometer::auth {
  
  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $service_password = pick(getvar("${fact_prefix}ceilometer_keystone_password"),pwgen())
  $auth_url = "http://${auth_host}:5000/v2.0"
  
  class { '::ceilometer::agent::auth':
    auth_url         => $auth_url,
    auth_region      => $::kickstack::keystone_region,
    auth_user        => 'ceilometer',
    auth_password    => $service_password,
    auth_tenant_name => $::kickstack::keystone_service_tenant,
  }

}

