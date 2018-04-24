# samba::firewall
#
class samba::firewall () inherits samba {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::firewall_manage and defined('::firewall') {
    $samba::hosts_allow.each |$network| {
      $samba::service_ports.each |$entry| {
        firewall { "${entry[port]} Allow inbound ${entry[proto]} connection on port: ${entry[port]} from: ${network}":
          dport  => $entry[port],
          source => $network,
          proto  => $entry[proto],
          action => accept,
        }
      }
    }
  }
}
