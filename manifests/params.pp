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

  if $facts['os']['family'] == 'Debian' {
    $installer_bin = 'Rapid7Setup-Linux64.bin'
    $installer_checksum = undef
    $installer_uri = "http://download2.rapid7.com/download/InsightVM/${installer_bin}"
    $install_path = '/opt/rapid7'
    $installer_path = "${install_path}/${installer_bin}"
    $varfile_name = 'response.varfile'
    $varfile_path = "${install_path}/${varfile_name}"
  }
  elsif $facts['os']['family'] == 'RedHat' {
    $installer_bin = 'Rapid7Setup-Linux64.bin'
    $installer_checksum = undef
    $installer_uri = "http://download2.rapid7.com/download/InsightVM/${installer_bin}"
    $install_path = '/opt/rapid7'
    $installer_path = "${install_path}/${installer_bin}"
    $varfile_name = 'response.varfile'
    $varfile_path = "${install_path}/${varfile_name}"
  }
  else {
    fail('OS Not supported.')
  }

}
