# == Class consul_alerts::params
#
class consul_alerts::params {

  $bin_dir            = '/usr/local/bin'
  $download_dir       = '/opt/consul-alerts'
  $download_url       = undef
  $download_url_base  = 'https://github.com/AcalephStorage/consul-alerts/releases/download/'
  $download_extension = 'tar'
  $service_name       = 'consul-alerts'
  $service_enable     = true
  $service_ensure     = 'running'
  $service_provider   = 'systemd'
  $manage_service      = true
  $manage_service_file = true
  $user               = 'root'
  $group              = 'root'
  $manage_user        = false
  $manage_group       = false
  $version            = '0.5.0'
  $config_options     = {
    '--alert-addr' => 'localhost:9000',
    '--consul-addr' => 'localhost:8500',
    '--consul-dc' => 'dc1',
  }

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    default:           {
      fail("Unsupported kernel architecture: ${::architecture}")
    }
  }
  $os = downcase($::kernel)

}
