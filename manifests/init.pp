# Class: samba
#
# For all main options, see the smb.conf(5) and samba(7) man pages.
# For the SELinux related options, see smbd_selinux(8).
#
# Sample Usage :
#  include samba
#
class samba (
  Struct[{
      server => Array[String[1]],
      client => Array[String[1]],
      utils  => Array[String[1]],
  }]      $packages,
  Boolean $package_manage,
  Samba::PackageState                  $package_ensure,
  String  $config_file,
  String  $config_lens,
  Variant[Enum[mask, manual], Boolean] $service_enable,
  Enum[stopped, running]               $service_ensure,
  Boolean $service_manage,
  Array[String]                        $service_name,
  Array[
    Struct[
      {
        port  => Integer[0, 65535],
        proto => Enum[tcp, udp],
      }
    ]
  ]       $service_ports,
  Boolean $firewall_manage,

  # Main smb.conf options
  Optional[String] $workgroup,
  Optional[String] $server_string,
  Optional[String] $netbios_name,
  Optional[Boolean] $domain_master,
  Optional[Boolean] $preferred_master,
  Optional[Boolean] $local_master,
  Optional[Integer[0, 255]] $os_level,
  Optional[Boolean] $wins_support,
  Optional[String] $wins_server,
  Optional[String] $name_resolve_order,
  Optional[String] $server_min_protocol,
  Optional[String] $client_max_protocol,
  Optional[String] $client_min_protocol,
  Array[String] $hosts_allow,
  Array[String] $hosts_deny,
  Array[String] $interfaces,
  Optional[Boolean] $bind_interfaces_only,
  Optional[String] $log_file,
  Optional[Integer] $max_log_size,
  Optional[String] $passdb_backend,
  Optional[Boolean] $domain_logons,
  Optional[String] $map_to_guest,
  Optional[String] $security,
  Optional[Boolean] $encrypt_passwords,
  Optional[Boolean] $unix_password_sync,
  Optional[String] $socket_options,
  Optional[String] $syslog,
  Optional[Boolean] $ntlm_auth,
  Optional[Integer] $machine_password_timeout,
  Optional[String] $realm,
  Optional[String] $kerberos_method,
  Optional[String] $dedicated_keytab_file,
  Optional[Boolean] $obey_pam_restrictions,
  Optional[Hash] $idmap_config,

  Hash $shares = {},
) {
  $incl = $config_file
  $context = "/files${incl}"
  $target = 'target[. = "global"]'

  if ($package_ensure in ['absent', 'purged']) {
    class { "${module_name}::install": }
  } else {
    contain 'samba::install'
    contain 'samba::config'
    contain 'samba::service'
    contain 'samba::firewall'

    Class['samba::install']
    -> Class['samba::config']
    ~> Class['samba::service']
    -> Class['samba::firewall']
  }
}
