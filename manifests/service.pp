# == Class consul_alerts::service
#
class consul_alerts::service inherits ::consul_alerts {

  if $::consul_alerts::manage_service {
    service { 'consul-alerts':
      ensure   => $::consul_alerts::service_ensure,
      enable   => $::consul_alerts::service_enable,
      name     => $::consul_alerts::service_name,
      provider => $::consul_alerts::service_provider,
    }
  }

}
