[![Build Status](https://travis-ci.org/rapid7/puppet-nexpose.svg?branch=production)](https://travis-ci.org/rapid7/puppet-nexpose)
# nexpose

#### Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Setup - The basics of getting started with nexpose](#setup)
    * [Beginning with nexpose](#beginning-with-nexpose)
    * [Dependencies](#dependencies)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Overview

Installs and manages your on-prem vulnerability scanner, [Nexpose](https://www.rapid7.com/products/nexpose/)

## Installation

```bash
puppet module install rapid7-nexpose
```

## Setup

### Beginning with nexpose

This will install a Nexpose Engine, ready to be paired with a Nexpose Console. Simple when having to provision multiple engines across your infrastructure.

```puppet
class { '::nexpose':
  component_type     => 'engine',
  first_name         => 'Rapid7',
  last_name          => 'User',
  company_name       => 'Rapid7 LLC',
}
```

### Dependencies

- puppetlabs/stdlib >= 1.0.0
- puppet-archive >= 0.5.1

See `metadata.json` for details.

## Usage

### Provision a Nexpose Console

```puppet
class { '::nexpose':
  component_type   => 'console',
  first_name       => 'Rapid7',
  last_name        => 'User',
  company_name     => 'Rapid7 LLC',
  nexpose_user     => 'nxadmin',
  nexpose_password => 'super-secret-password',
}
```

### Provision a Nexpose Engine using a proxy for updates

```puppet
class { '::nexpose':
  component_type => 'engine',
  first_name     => 'Rapid7',
  last_name      => 'User',
  company_name   => 'Rapid7 LLC',
  proxy_uri      => 'myproxy.example.com:1234',
}
```

## Reference

### Classes

#### Public classes

* `nexpose` - Main class, includes all other classes.

#### Private classes

* `nexpose::install` - Installs Nexpose.
* `nexpose::params` - Defines the default paramaters.
* `nexpose::service` - Handles the Nexpose service.

### Parameters

The following parameters are available in the `::nexpose` class:

#### `first_name`

Optional.

Data type: String.

Defines the First Name value when installing Nexpose.

Default value: 'Rapid7'.

#### `last_name`

Optional.

Data type: String.

Defines the Last Name value when installing Nexpose.

Default value: 'User'.

#### `company_name`

Optional.

Data type: String.

Defines the Company Name value when installing Nexpose.

Default value: 'Awesome Company'.

#### `component_type`

Optional.

Data type: String.

Defines if Nexpose will be installed as a Console or Engine. Valid values are `engine` or `console` (`typical` is also valid, same as console)

Default value: 'engine'.

#### `nexpose_user`

Optional.

Data type: String.

Defines the username of the Nexpose Administrator account when provisioning a Console type.

Default value: 'nxadmin'.

#### `nexpose_password`

Optional.

Data type: String.

Defines the password of the Nexpose Administrator account when provisioning a Console type.

Default value: 'nxadmin'.

#### `proxy_uri`

Optional.

Data type: String.

Defines the proxy Nexpose will use when pulling software updates.

Default value: `undef`.

#### `suppress_reboot`

Optional.

Data type: Boolean.

By default, the Nexpose installer reboots the system after installation. This suppresses that action.

Default value: `true`.

#### `service_enable`

Optional.

Data type: Boolean.

Defines if Nexpose should start on system boot.

Default value: `true`.

#### `service_ensure`

Optional.

Data type: String.

If Nexpose isn't running, Puppet will start it.

Default value: 'running'.

## Limitations

This module has only been tested on Ubuntu 14.04 and 16.04.

## Development

Coming soon..