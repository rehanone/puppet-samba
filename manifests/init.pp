# Class: samba
#
# For all main options, see the smb.conf(5) and samba(7) man pages.
# For the SELinux related options, see smbd_selinux(8).
#
# Sample Usage :
#  include samba
#
class samba (
  Boolean $package_manage  = $samba::params::package_manage,
  String  $package_ensure  = $samba::params::package_ensure,
  String  $package_server  = $samba::params::package_server,
  String  $package_client  = $samba::params::package_client,
  String  $package_utils   = $samba::params::package_utils,
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
  Optional[String] $workgroup                = $samba::params::workgroup,
  Optional[String] $server_string            = $samba::params::server_string,
  Optional[String] $netbios_name             = $samba::params::netbios_name,
  Optional[Boolean] $domain_master            = $samba::params::domain_master,
  Optional[Boolean] $preferred_master         = $samba::params::preferred_master,
  Optional[Boolean] $local_master             = $samba::params::local_master,
  Optional[Integer[255]] $os_level                 = $samba::params::os_level,
  Optional[Boolean] $wins_support             = $samba::params::wins_support,
  Optional[String] $wins_server              = $samba::params::wins_server,
  Optional[String] $name_resolve_order       = $samba::params::name_resolve_order,
  Optional[String] $server_min_protocol      = $samba::params::server_min_protocol,
  Optional[String] $client_max_protocol      = $samba::params::client_max_protocol,
  Optional[String] $client_min_protocol      = $samba::params::client_min_protocol,
  Array[String] $hosts_allow              = $samba::params::hosts_allow,
  Array[String] $hosts_deny               = $samba::params::hosts_deny,
  Array[String] $interfaces               = $samba::params::interfaces,
  Optional[Boolean] $bind_interfaces_only     = $samba::params::bind_interfaces_only,
  Optional[String] $log_file                 = $samba::params::log_file,
  Optional[Integer] $max_log_size             = $samba::params::max_log_size,
  Optional[String] $passdb_backend           = $samba::params::passdb_backend,
  Optional[Boolean] $domain_logons            = $samba::params::domain_logons,
  Optional[String] $map_to_guest             = $samba::params::map_to_guest,
  Optional[String] $security                 = $samba::params::security,
  Optional[Boolean] $encrypt_passwords        = $samba::params::encrypt_passwords,
  Optional[Boolean] $unix_password_sync       = $samba::params::unix_password_sync,
  Optional[String] $socket_options           = $samba::params::socket_options,
  Optional[String] $syslog                   = $samba::params::syslog,

  Hash $shares                   = lookup('samba::shares', Hash, 'hash', {}),
) inherits ::samba::params {

  $incl    = $config_file
  $context = "/files${incl}"
  $target  = 'target[. = "global"]'

  if ($package_ensure in [ 'absent', 'purged' ]) {
    class { "${module_name}::install": }
  } else {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::install": }
    -> class { "${module_name}::config": }
    ~> class { "${module_name}::service": }
    -> class { "${module_name}::firewall": }
    -> anchor { "${module_name}::end": }
  }
}
