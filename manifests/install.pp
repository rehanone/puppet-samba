# samba::install
#
class samba::install () inherits samba {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::package_manage {
    if !defined(Package[$samba::packages[server]]) {
      package { $samba::packages[server]:
        ensure => $samba::package_ensure,
      }
    }
    if !defined(Package[$samba::packages[utils]]) {
      package { $samba::packages[utils]:
        ensure => $samba::package_ensure,
      }
    }
  }
}
