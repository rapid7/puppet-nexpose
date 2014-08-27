class nexpose::service (

  $service_name,
  $service_enable = true,
  $service_ensure = 'running',

) {

  service { $service_name:
    enable     => $service_enable,
    ensure     => $service_ensure,
    hasstatus  => false,
    status     => "pgrep ${::nexpose::service_process}",
    require    => Exec['install_nexpose'],
  }

}
