# == Class: nexpose
#
# Full description of class nexpose here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nexpose:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class nexpose (

  $first_name         = $::nexpose::params::first_name,
  $last_name          = $::nexpose::params::last_name,
  $company_name       = $::nexpose::params::company_name,
  $component_type     = $::nexpose::params::component_type,
  $nexpose_user       = $::nexpose::params::nexpose_user,
  $nexpose_password   = $::nexpose::params::nexpose_password,
  $proxy_uri          = $::nexpose::params::proxy_uri,
  $suppress_reboot    = $::nexpose::params::suppress_reboot,
  $installer_checksum = $::nexpose::params::installer_checksum,
  $installer_uri      = $::nexpose::params::installer_uri,
  $install_path       = $::nexpose::params::install_path,
  $service_enable     = $::nexpose::params::service_enable,
  $service_ensure     = $::nexpose::params::service_ensure,

) inherits ::nexpose::params {

  $valid_component_type_re = '(typical|console|engine)'
  validate_re($component_type, $valid_component_type_re,
  "Component type ${component_type} needs to be one of the following: typical, console, engine")

  $nexpose_init = $component_type ? {
    'engine'            => $::osfamily ? {
      'Debian' =>  $::lsbdistcodename ? {
        'trusty' => 'nexposeengine.rc',
        'xenial' => 'nexposeengine.service',
        'bionic' => 'nexposeengine.service',
      },
      'RedHat' => 'nexposeengine',
    },
    /(console|typical)/ => $::osfamily ? {
      'Debian' =>  $::lsbdistcodename ? {
        'trusty' => 'nexposeconsole.rc',
        'xenial' => 'nexposeconsole.service',
        'bionic' => 'nexposeconsole.service',
      },
      'RedHat' => 'nexposeconsole',
    }
  }

  case $component_type {
    'engine': {
      $console_bool    = false
      $engine_bool     = true
      $service_process = 'nse.sh'
    }
    'console', 'typical': {
      $console_bool    = true
      $engine_bool     = false
      $service_process = 'nsc.sh'
    }
  }

  class { '::nexpose::install':
    component_type => $component_type,
  }

  class { '::nexpose::service':
    service_name   => $nexpose_init,
    service_enable => $service_enable,
    service_ensure => $service_ensure,
  }

  contain '::nexpose::install'
  contain '::nexpose::service'

  Class['::nexpose::install']
  -> Class['::nexpose::service']
}
