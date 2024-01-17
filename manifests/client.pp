# samba::client
#
# @param packages
# TODO
# @param packages_manage
# TODO
# @param packages_ensure
# TODO
class samba::client (
  Struct[{
      server => Array[String[1]],
      client => Array[String[1]],
      utils  => Array[String[1]],
  }]                  $packages       = $samba::packages,
  Boolean             $package_manage = $samba::package_manage,
  Samba::PackageState $package_ensure = $samba::package_ensure,
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
