# rehan-samba

[![Puppet Forge](http://img.shields.io/puppetforge/v/rehan/samba.svg)](https://forge.puppetlabs.com/rehan/samba) [![Build Status](https://travis-ci.com/rehanone/puppet-samba.svg?branch=master)](https://travis-ci.com/rehanone/puppet-samba)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
    * [Classes](#classes)
    * [Referances](#referances)
5. [Dependencies](#dependencies)
6. [Development](#development)

## Overview
The `rehan-samba` module manages the Samba/CIFS, the virtual filesystem based on SMB protocol.

## Module Description
A puppet module for managing the installation and configuration of [samba](https://www.samba.org/). This module installs and configures the samba server and client packages and allows configuration of user
specific SMB shares.

#### Implemented Features:
* Installs samba server package
* Installs samba client package
* Allows managing global SMB configurations parameters.
* Allows managing SMB shares.

## Setup
In order to install `rehan-samba`, run the following command:
```bash
$ puppet module install rehan-samba
```
The module does expect all the data to be provided through 'Hiera'. See [Usage](#usage) for examples on how to configure it.

#### Requirements
This module is designed to be as clean and compliant with latest puppet code guidelines.

## Usage

### Example Usage (puppet dsl)

    class { 'samba':
      package_ensure       => 'installed'
      os_level             => 50,
      workgroup            => 'EXAMPLE',
      wins_server          => '10.10.10.10',
      server_string        => 'Example File Server 01',
      netbios_name         => 'F01',
      interfaces           => [ 'lo', 'eth0' ],
      hosts_allow          => [ '127.', '192.168.' ],
      hosts_deny           => [ 'ALL' ]
      local_master         => 'yes',
      preferred_master     => 'yes',
      map_to_guest         => 'Bad User',
      shares => {
        'homes' => {
          comment    => 'Home Directories',
          browseable => false,
          path       => '/home',
          writable   => true,
        },
        'pictures' => {
          comment        => 'Pictures',
          path           => '/srv/pictures',
          browseable     => true,
          writable       => true,
          create_mask    => '1777',
          directory_mask => '1777',
        },
      },
    }


### Example Usage (hiera)

All of this data can be provided through `Hiera`.

**YAML**
```yaml
samba::package_selection:
   server:
      ensure: "%{alias('samba::package_ensure')}"
   client:
      ensure: "%{alias('samba::package_ensure')}"
   utils:
      ensure: "%{alias('samba::package_ensure')}"
samba::package_ensure: 'installed'
samba::os_level: 50
samba::workgroup: 'EXAMPLE'
samba::wins_server: '10.10.10.10'
samba::server_string: 'Example File Server 01'
samba::netbios_name: 'F01'
samba::interfaces:
   - 'lo'
   - 'eth0'
samba::hosts_allow:
   - '127.'
   - '192.168.'
samba::hosts_deny:
   - 'ALL'
samba::local_master: 'yes'
samba::preferred_master: 'yes'
samba::map_to_guest: 'Bad User'
samba::firewall_manage: true
samba::shares:
  'homes':
    comment: 'Home Directories'
    browseable: false
    path: '/home'
    writable: true
  'pictures':
    comment: 'Pictures'
    path: '/srv/pictures'
    browseable: true
    writable: true
    create_mask: '1777'
    directory_mask: '1777'
```

## Dependencies

* [stdlib][1]
* [augeas_core][2]

[1]:https://forge.puppet.com/puppetlabs/stdlib
[2]:https://forge.puppet.com/puppetlabs/augeas_core

## Development

You can submit pull requests and create issues through the official page of this module on [GitHub](https://github.com/rehan/puppet-samba).
Please do report any bug and suggest new features/improvements.
