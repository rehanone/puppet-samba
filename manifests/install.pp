# samba::install
#
class samba::install () inherits samba {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::package_manage {
    package { $samba::packages[server]:
      ensure => $samba::package_ensure,
    }

    package { $samba::packages[utils]:
      ensure => $samba::package_ensure,
    }
  }
}
