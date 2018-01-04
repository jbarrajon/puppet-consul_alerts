# == Class consul_alerts::config
#
class consul_alerts::config inherits ::consul_alerts {

  if $::consul_alerts::manage_service_file {
    case $::consul_alerts::service_provider {
      'systemd' : {
        file { '/lib/systemd/system/consul-alerts.service':
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('consul_alerts/consul-alerts.systemd.erb'),
        }
      }
      default : {
        fail("consul_alerts::service_provider '${::consul_alerts::service_provider}' is not supported")
      }
    }
  }

}
