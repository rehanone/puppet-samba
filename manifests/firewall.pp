# @summary: Manage the firewall
#
class samba::firewall () inherits samba {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $samba::firewall_manage {
    $samba::hosts_allow.each |$network| {
      $samba::service_ports.each |$entry| {
        if defined('::firewall') {
          firewall { "${entry[port]} Allow SAMBA ${entry[proto]} connection on port: ${entry[port]} from: ${network}":
            dport  => $entry[port],
            source => $network,
            proto  => $entry[proto],
            action => accept,
          }
        }

        if defined('::ferm') {
          ferm::rule { "${entry[port]} Allow SAMBA ${entry[proto]} connection on port: ${entry[port]} from: ${network}":
            chain  => 'INPUT',
            action => 'ACCEPT',
            proto  => $entry[proto],
            dport  => $entry[port],
            saddr  => $network,
          }
        }
      }
    }
  }
}
