# @summary: This module installs the SAMBA/CIFS client.
# samba::client
#
# @param packages
#    The name of the Samba client package.
#
# @param package_manage
#    Should the Samba client package be managed by this module?
#
# @param package_ensure
#    The installation state of the Samba client package
#
class samba::client (
  Struct[{
      server => Array[String[1]],
      client => Array[String[1]],
      utils  => Array[String[1]],
  }]                  $packages       = $samba::packages,
  Boolean             $package_manage = $samba::package_manage,
  Stdlib::Ensure::Package $package_ensure = $samba::package_ensure,
) {
  if $package_manage {
    package { $packages[client]:
      ensure => $package_ensure,
    }

    package { $packages[utils]:
      ensure => $package_ensure,
    }
  }
}
