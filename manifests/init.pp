# == Class: consul_alerts
#
# Installs, configures, and manages consul-alerts
#
class consul_alerts (
  $bin_dir             = $::consul_alerts::params::bin_dir,
  $download_dir        = $::consul_alerts::params::download_dir,
  $download_url        = $::consul_alerts::params::download_url,
  $download_url_base   = $::consul_alerts::params::download_url_base,
  $download_extension  = $::consul_alerts::params::download_extension,
  $service_name        = $::consul_alerts::params::service_name,
  $service_provider    = $::consul_alerts::params::service_provider,
  $service_enable      = $::consul_alerts::params::service_enable,
  $service_ensure      = $::consul_alerts::params::service_ensure,
  $manage_service      = $::consul_alerts::params::manage_service,
  $manage_service_file = $::consul_alerts::params::manage_service_file,
  $user                = $::consul_alerts::params::user,
  $group               = $::consul_alerts::params::group,
  $manage_user         = $::consul_alerts::params::manage_user,
  $manage_group        = $::consul_alerts::params::manage_group,
  $version             = $::consul_alerts::params::version,
  $os                  = $::consul_alerts::params::os,
  $arch                = $::consul_alerts::params::arch,
  $config_options      = $::consul_alerts::params::config_options,
) inherits ::consul_alerts::params {

  validate_string($user)
  validate_string($group)
  validate_bool($manage_user)
  validate_bool($manage_group)
  validate_hash($config_options)

  $real_download_url = pick($download_url, "${download_url_base}v${version}/consul-alerts-${version}-${os}-${arch}.${download_extension}")

  $final_config_options = lookup('consul_alerts::config_options', { 'value_type' => Hash, 'merge' => 'deep', 'default_value' => $config_options })

  include ::consul_alerts::install
  include ::consul_alerts::config
  include ::consul_alerts::service

  Class['::consul_alerts::install'] -> Class['::consul_alerts::config']
  Class['::consul_alerts::config'] ~> Class['::consul_alerts::service']

}
