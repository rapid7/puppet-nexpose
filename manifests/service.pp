class nexpose::service ( 

  $service_name,
  $service_enable = true,
  $service_ensure = 'running',

) {

  service { $service_name:
    enable => true,
    ensure => running,
  }

}
