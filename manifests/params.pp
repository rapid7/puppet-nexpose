class nexpose::params {

  $first_name       = 'Nexpose'
  $last_name        = 'User'
  $company_name     = 'Awesome Company'
  $component_type   = 'engine'
  $nexpose_user     = 'nxadmin'
  $nexpose_password = 'nxadmin'
  $proxy_uri        = undef
  $suppress_reboot  = true
  $service_enable   = true
  $service_ensure   = 'running'

  if $::osfamily == 'Debian' {
    if $::lsbdistrelease == '14.04' or $::lsbdistrelease == '16.04' {
      $installer_bin = 'NeXposeSetup-Linux64.bin'
      $installer_checksum = undef
      $installer_uri = "https://download2.rapid7.com/download/NeXpose-v4/${installer_bin}"
      $install_path = '/opt/rapid7'
      $installer_path = "${install_path}/${installer_bin}"
      $varfile_name = 'response.varfile'
      $varfile_path = "${install_path}/${varfile_name}"
    }
  }
  elsif $::osfamily == 'RedHat' {
      $installer_bin = 'NeXposeSetup-Linux64.bin'
      $installer_checksum = undef
      $installer_uri = "https://download2.rapid7.com/download/NeXpose-v4/${installer_bin}"
      $install_path = '/opt/rapid7'
      $installer_path = "${install_path}/${installer_bin}"
      $varfile_name = 'response.varfile'
      $varfile_path = "${install_path}/${varfile_name}"
  }
  else {
    fail('OS Not supported.')
  }

}
