class nexpose::install (

  $component_type,
  $proxy_host = undef,
  $proxy_port = undef,

) {

  package { 'screen':
    ensure => present,
  }

  file { 'rapid7_directory':
    ensure => directory,
    path   => $::nexpose::install_path,
    owner  => 'root',
    group  => 'root',
  }

  file { 'nexpose_directory':
    ensure  => directory,
    path    => "${::nexpose::install_path}/nexpose",
    require => Exec['install_nexpose'],
  }

  file { 'response_varfile':
    ensure  => file,
    path    => $::nexpose::varfile_path,
    content => template('nexpose/response.varfile.erb'),
    mode    => '0750',
    owner   => 'root',
    group   => 'root',
  }

  file { 'nexpose_installer':
    path    => "${::nexpose::installer_path}",
    mode    => '0750',
    require => Exec['download_installer'],
    owner   => 'root',
    group   => 'root',
  }

  exec { 'download_installer':
    command => "/usr/bin/wget -O ${::nexpose::installer_path} ${::nexpose::installer_uri}",
    require => File['rapid7_directory'],
    creates => $::nexpose::installer_path,
  }

  exec { 'install_nexpose':
    command => "${::nexpose::installer_path} -q -Dinstall4j.suppressUnattendedReboot=${::nexpose::suppress_reboot} -varfile ${::nexpose::varfile_path}",
    require => File['response_varfile'],
    creates => "${::nexpose::install_path}/nexpose",
  }

}
