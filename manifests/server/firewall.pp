# samba::server::firewall
#
class samba::server::firewall () inherits samba::server {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::server::firewall_manage and defined('::firewall') {
    $samba::server::hosts_allow.each |$network| {
      $samba::server::service_ports.each |$entry| {
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
