# samba::service
#
class samba::service () inherits samba {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  if !($samba::service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $samba::service_manage == true {
    service { $samba::service_name:
      ensure     => $samba::service_ensure,
      enable     => $samba::service_enable,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => Class["${module_name}::config"],
    }
  }
}
