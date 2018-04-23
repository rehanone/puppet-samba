class samba::server::service () inherits samba::server {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if !($samba::server::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $samba::server::service_manage == true {
    service { $samba::server::service_name:
      ensure     => $samba::server::service_ensure,
      enable     => $samba::server::service_enable,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => Class["${module_name}::server::config"],
    }
  }
}
