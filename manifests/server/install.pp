class samba::server::install () inherits samba::server {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  package { $samba::server::package_server:
    ensure => $samba::server::package_ensure,
    alias  => 'samba',
  }
}
