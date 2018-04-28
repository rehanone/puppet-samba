# samba::install
#
class samba::install () inherits samba {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::package_manage {

    package { $samba::package_server:
      ensure => $samba::package_ensure,
      alias  => 'samba',
    }

    package { $samba::package_client:
      ensure => $samba::package_ensure,
    }

    package { $samba::package_utils:
      ensure => $samba::package_ensure,
    }
  }
}
