# Class: samba::server
#
# Samba server.
#
# For all main options, see the smb.conf(5) and samba(7) man pages.
# For the SELinux related options, see smbd_selinux(8).
#
# Sample Usage :
#  include samba::server
#
class samba::server (
  String  $package_ensure  = $samba::params::package_ensure,
  String  $package_server  = $samba::params::package_server,
  String  $config_file     = $samba::params::config_file,
  Variant[Enum[mask, manual], Boolean]
          $service_enable  = $samba::params::service_enable,
  Enum[stopped, running]
          $service_ensure  = $samba::params::service_ensure,
  Boolean $service_manage  = $samba::params::service_manage,
  Array[String]
          $service_name    = $samba::params::service_name,
  Array[Struct[{
    port  => Integer[0, 65535],
    proto => Enum[tcp, udp]
  }]]     $service_ports   = $samba::params::service_ports,
  Boolean $firewall_manage = $samba::params::firewall_manage,

  # Main smb.conf options
  $workgroup                = $samba::params::workgroup,
  $server_string            = $samba::params::server_string,
  $netbios_name             = $samba::params::netbios_name,
  $domain_master            = $samba::params::domain_master,
  $preferred_master         = $samba::params::preferred_master,
  $local_master             = $samba::params::local_master,
  $os_level                 = $samba::params::os_level,
  $wins_support             = $samba::params::wins_support,
  $wins_server              = $samba::params::wins_server,
  $name_resolve_order       = $samba::params::name_resolve_order,
  $server_min_protocol      = $samba::params::server_min_protocol,
  $client_max_protocol      = $samba::params::client_max_protocol,
  $client_min_protocol      = $samba::params::client_min_protocol,
  $hosts_allow              = $samba::params::hosts_allow,
  $hosts_deny               = $samba::params::hosts_deny,
  $interfaces               = $samba::params::interfaces,
  $bind_interfaces_only     = $samba::params::bind_interfaces_only,
  $log_file                 = $samba::params::log_file,
  $max_log_size             = $samba::params::max_log_size,
  $passdb_backend           = $samba::params::passdb_backend,
  $domain_logons            = $samba::params::domain_logons,
  $map_to_guest             = $samba::params::map_to_guest,
  $security                 = $samba::params::security,
  $encrypt_passwords        = $samba::params::encrypt_passwords,
  $unix_password_sync       = $samba::params::unix_password_sync,
  $socket_options           = $samba::params::socket_options,

  $syslog                   = $samba::params::syslog,

  $shares                   = hiera_array('samba::server::shares', {}),
) inherits ::samba::params {

  $incl    = $config_file
  $context = "/files/${incl}"
  $target  = 'target[. = "global"]'

  if ($package_ensure in [ 'absent', 'purged' ]) {
    class { "${module_name}::server::install": }
  } else {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::server::install": }
    -> class { "${module_name}::server::config": }
    ~> class { "${module_name}::server::service": }
    -> class { "${module_name}::server::firewall": }
    -> anchor { "${module_name}::end": }
  }
}	
