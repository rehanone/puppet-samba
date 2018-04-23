class samba::client (
  String $package_ensure  = $samba::params::package_ensure,
  String $package_client  = $samba::params::package_client,
  String $package_utils   = $samba::params::package_utils,
  ) inherits samba::params {

  package { $package_client:
    ensure => $package_ensure,
  }

  package { $package_utils:
    ensure => $package_ensure,
  }
}
