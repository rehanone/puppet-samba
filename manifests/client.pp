# samba::client
#
class samba::client (
  Struct[{
    server => Array[String[1]],
    client => Array[String[1]],
    utils  => Array[String[1]],
  }]                  $packages       = lookup('samba::packages'),
  Boolean             $package_manage = lookup('samba::package_manage'),
  Samba::PackageState $package_ensure = lookup('samba::package_ensure'),
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
