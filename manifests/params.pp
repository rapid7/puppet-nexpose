class nexpose::params {

  $first_name = 'Nexpose'
  $last_name = 'User'
  $company_name = 'Rapid7 LLC'
  $component_type = 'engine'
  $nexpose_user = 'nxadmin'
  $nexpose_password = 'nxadmin'
  $proxy_host = undef
  $proxy_port = undef
  $suppress_reboot = true
  $service_enable = true
  $service_ensure = 'running'

  if $::operatingsystem == 'Ubuntu' {
    if $::lsbdistrelease == '14.04' or $::lsbdistrelease == '16.04' {
      $installer_bin = 'NeXposeSetup-Linux64.bin'
      $installer_checksum = undef
      $installer_uri = "http://download2.rapid7.com/download/NeXpose-v4/${installer_bin}"
      $install_path = '/opt/rapid7'
      $installer_path = "${install_path}/${installer_bin}"
      $varfile_name = 'response.varfile'
      $varfile_path = "${install_path}/${varfile_name}"
    }
  }
  elsif $::operatingsystem == 'RedHat' {
      $installer_bin = 'NeXposeSetup-Linux64.bin'
      $installer_checksum = undef
      $installer_uri = "http://download2.rapid7.com/download/NeXpose-v4/${installer_bin}"
      $install_path = '/opt/rapid7'
      $installer_path = "${install_path}/${installer_bin}"
      $varfile_name = 'response.varfile'
      $varfile_path = "${install_path}/${varfile_name}"
  }
  else {
    fail('Currently this module only supports Ubuntu 14.04 and 16.04, and Redhat 7.2')
  }

}
