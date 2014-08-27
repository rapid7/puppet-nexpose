class nexpose::install ( 

  $component_type,

) {

  package { 'screen':
    ensure => present,
  }

  file { 'rapid7_directory':
    path   => $install_path,
    ensure => directory,
    user   => 'root',
    group  => 'root',
  }

  file { 'response_varfile':
    path    => $varfile_path,
    ensure  => file,
    content => template('nexpose/response.varfile.erb'),
    user    => 'root',
    group   => 'root',
  }

  exec { 'download_installer':
    command => "/usr/bin/wget -O ${installer_path} ${installer_uri}",
    require => File['rapid7_directory'],
    creates => $installer_path,
  }

  exec { 'install_nexpose':
    command => "${installer_path} -q -Dinstall4j.suppressUnattendedReboot=$suppress_reboot -varfile $varfile_path",
    require => File['response_varfile'],
    creates => "${install_path}/nexpose",
  }

}
