# == Class consul_alerts::install
#
class consul_alerts::install inherits ::consul_alerts {

    file { $::consul_alerts::download_dir:
      ensure => 'directory',
      owner  => $::consul_alerts::user,
      group  => $::consul_alerts::group,
      mode   => '0755',
    }
    file { "${::consul_alerts::download_dir}/${::consul_alerts::version}":
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0555',
    } ->
    archive { "${::consul_alerts::download_dir}/${::consul_alerts::version}.${::consul_alerts::download_extension}":
      ensure       => present,
      source       => $::consul_alerts::real_download_url,
      extract      => true,
      extract_path => "${::consul_alerts::download_dir}/${::consul_alerts::version}",
      creates      => "${::consul_alerts::download_dir}/${::consul_alerts::version}/consul-alerts",
    } ->
    file { "${::consul_alerts::download_dir}/${::consul_alerts::version}/consul-alerts":
      owner => 'root',
      group => 'root',
      mode  => '0555',
    }
    file { "${::consul_alerts::bin_dir}/consul-alerts":
      ensure => link,
      target => "${::consul_alerts::download_dir}/${::consul_alerts::version}/consul-alerts",
    }

  if $::consul_alerts::manage_user {
    user { $::consul_alerts::user:
      ensure => 'present',
      system => true,
    }
    if $::consul_alerts::manage_group {
      Group[$::consul_alerts::group] -> User[$::consul_alerts::user]
    }
  }
  if $::consul_alerts::manage_group {
    group { $::consul_alerts::group:
      ensure => 'present',
      system => true,
    }
  }

}
