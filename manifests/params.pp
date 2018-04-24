# Class: samba::params
#
class samba::params {
  $package_manage   = true
  $package_ensure   = 'latest'
  $package_server   = 'samba'
  $package_client   = $::facts[os][family] ? {
    'Redhat' => 'samba-client',
    'Debian' => 'smbclient',
    default  => '',
  }
  $package_utils    = 'cifs-utils'
  $config_file      = '/etc/samba/smb.conf'
  $service_enable   = true
  $service_ensure   = 'running'
  $service_manage   = true
  $service_ports    = [
    { port => 137, proto => udp, },
    { port => 138, proto => udp, },
    { port => 139, proto => tcp, },
    { port => 445, proto => tcp, },
  ]
  $firewall_manage  = false

  $workgroup                = 'WORKGROUP'
  $server_string            = '%h server (Samba Server Version %v)'
  $netbios_name             = $::hostname
  $domain_master            = undef
  $preferred_master         = undef
  $local_master             = undef
  $os_level                 = undef
  $wins_support             = undef
  $wins_server              = undef
  $name_resolve_order       = 'wins lmhosts hosts bcast'
  $server_min_protocol      = 'SMB2_10'
  $client_max_protocol      = 'SMB3'
  $client_min_protocol      = 'SMB2_10'
  $hosts_allow              = []
  $hosts_deny               = ['ALL']
  $interfaces               = []
  $bind_interfaces_only     = undef
  $log_file                 = '/var/log/samba/log.%m'
  $max_log_size             = 10000
  $passdb_backend           = 'tdbsam'
  $domain_logons            = false
  $security                 = 'user'
  $encrypt_passwords        = true
  $unix_password_sync       = true
  $map_to_guest             = 'Never'
  $socket_options           = 'TCP_NODELAY'
  $syslog                   = undef
  $extra_global_options     = []

  case $::facts[os][family] {
    'Archlinux': {
      $service_name = [ 'smbd', 'nmbd' ]
    }
    'RedHat': {
      $service_name = [ 'smb', 'nmb' ]
    }
    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        $service_name = [ 'smbd', 'nmbd' ]
      } else {
        $service_name = [ 'samba' ]
      }
    }
    default: {
      $service_name = [ 'samba' ]
    }
  }
}

