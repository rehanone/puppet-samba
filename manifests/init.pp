# @summary
#   This module manages Samba/CIFS, the virtual filesystem based on SMB protocol.
#
# For all main options, see the smb.conf(5) and samba(7) man pages.  Default values for all
# parameters can be found at https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html.
# For the SELinux related options, see smbd_selinux(8).
#
# Sample Usage :
#  include samba
#
# @param packages
#    Names of the server, client and utility pacakges to be installed when managing Samba.
#
# @param package_manage
#    Should this module manage the installation/removal of the $packages?
#
# @param package_ensure
#    The installation state of $packages.
#
# @param config_file
#    The Augeas lens to use for managing the smb.conf file.
#
# @param config_lens
#    The Augeas lens to use for managing the smb.conf file.
#
# @param service_enable
#    Enable/disable the Samba service on reboot.
#
# @param service_ensure
#   The value of ``ensure`` for package resources.
#
# @param service_manage
#   Should the Samba service be managd by this module?
#
# @param service_name
#   The name of the Samba service.
#
# @param service_ports
#    The service ports to be added to the firewall (if managed).
#
# @param firewall_manage
#    Manage the firewall rules for the Samba services.
#
# @param workgroup
#    This controls what workgroup your server will appear to be in when queried by clients.
#
# @param server_string
#    This controls what string will show up in the printer comment box in print manager and next to the IPC connection in net view.
#
# @param netbios_name
#    This sets the NetBIOS name by which a Samba server is known.
#
# @param domain_master
#    Tell smbd(8) to enable WAN-wide browse list collation.
#
# @param preferred_master
#    This boolean parameter controls if nmbd(8) is a preferred master browser for its workgroup.
#
# @param local_master
#    This option allows nmbd(8) to try and become a local master browser on a subnet.
#
# @param os_level
#    This integer value controls what level Samba advertises itself as for browse elections.
#
# @param wins_support
#    This boolean controls if the nmbd(8) process in Samba will act as a WINS server. 
#
# @param wins_server
#    This specifies the IP address (or DNS name: IP address for preference) of the WINS server that nmbd(8) should register with.
#
# @param name_resolve_order
#    This option is used by the programs in the Samba suite to determine what naming services to use and in what order to resolve host names to IP addresses.
#
# @param server_min_protocol
#    This setting controls the minimum protocol version that the server will allow the client to use.
#
# @param client_max_protocol
#    The value of the parameter (a string) is the highest protocol level that will be supported for IPC$ connections as DCERPC transport.
#
# @param client_min_protocol
#    This setting controls the minimum protocol version that the client will attempt to use.
#
# @param hosts_allow
#    This parameter is a comma, space, or tab delimited set of hosts which are permitted to access a service.
#
# @param hosts_deny
#    The opposite of hosts allow - hosts listed here are NOT permitted access to services unless the specific services have their own lists to override this one.
#
# @param interfaces
#    default: interfaces =
#
# @param bind_interfaces_only
#    This global parameter allows the Samba admin to limit what interfaces on a machine will serve SMB requests.
#
# @param log_file
#    This option allows you to override the name of the Samba log file (also known as the debug file).
#
# @param max_log_size
#    This option (an integer in kilobytes) specifies the max size the log file should grow to.
#
# @param passdb_backend
#    This option allows the administrator to chose which backend will be used for storing user and possibly group information.
#
# @param domain_logons
#    DEPRECATED:  This parameter has been deprecated since Samba 4.13 and support for NT4-style domain logons(as distinct from the Samba AD DC) will be removed in a future Samba release.
#
# @param map_to_guest
#    This parameter can take four different values, which tell smbd(8) what to do with user login requests that don't match a valid UNIX user in some way.
#
# @param security
#    This option affects how clients respond to Samba.
#
# @param encrypt_passwords
#    DEPRECATED: This boolean controls whether encrypted passwords will be negotiated with the client
#
# @param unix_password_sync
#    This boolean parameter controls whether Samba attempts to synchronize the UNIX password with the SMB password when the encrypted SMB password in the smbpasswd file is changed.
#
# @param socket_options
#   This option allows you to set socket options to be used when talking with the client.
#
# @param syslog
#    This parameter maps how Samba debug messages are logged onto the system syslog logging levels.
#
# @param ntlm_auth
#    This parameter determines whether or not smbd(8) will attempt to authenticate users using the NTLM encrypted password response for this local passdb (SAM or account database).
#
# @param machine_password_timeout
#    This parameter specifies how often the MACHINE ACCOUNT password will be changed, in seconds.
#
# @param realm
#    This option specifies the kerberos realm to use.
#
# @param kerberos_method
#    Controls how kerberos tickets are verified.
#
# @param dedicated_keytab_file
#    Specifies the absolute path to the kerberos keytab file when kerberos method is set to "dedicated keytab".
#
# @param obey_pam_restrictions
#    This parameter will control whether or not Samba should obey PAM's account and session management directives.
# @param shares
#    A hash of share names, their path(s) and other parameters.
#
# @param idmap_config
#    The mapping between Windows SIDs and Unix user and group IDs.
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
  Variant[Undef, String] $workgroup    =  'WORKGROUP',
  Variant[Undef, String] $server_string = '%h server (Samba Server Version %v)',
  Variant[Undef, String] $netbios_name  = '%{facts.hostname}',
  Variant[Boolean, String] $domain_master = 'auto',
  Variant[Boolean, String] $preferred_master = 'auto',
  Variant[Undef, Boolean] $local_master = true,
  Variant[Undef, Integer[0, 255]] $os_level = 20,
  Variant[Undef, Boolean] $wins_support = false,
  Variant[Undef, String] $wins_server = undef,
  Variant[Undef, String] $name_resolve_order = 'lmhosts wins host bcast',
  Variant[Undef, String] $server_min_protocol = 'SMB2_10',
  Variant[Undef, String] $client_max_protocol = 'SMB3',
  Variant[Undef, String] $client_min_protocol = 'SMB2_10',
  Array[String] $hosts_allow = [],
  Array[String] $hosts_deny = ['ALL'],
  Array[String] $interfaces = [],
  Variant[Undef, Boolean] $bind_interfaces_only = false,
  Variant[Undef, String] $log_file = '/var/log/samba/log.%m',
  Variant[Undef, Integer] $max_log_size = 10000,
  Variant[Undef, String] $passdb_backend = 'tdbsam',
  Variant[Undef, Boolean] $domain_logons = false,
  Variant[Undef, String] $map_to_guest = 'Never',
  Variant[Undef, String] $security = 'auto',
  Variant[Undef, Boolean] $encrypt_passwords = true,
  Variant[Undef, Boolean] $unix_password_sync = false,
  Variant[Undef, String] $socket_options = 'TCP_NODELAY',
  Variant[Undef, String] $syslog = undef,
  Variant[Enum['ntlmv1-permitted', 'ntlmv2-only', 'mschapv2-and-ntlmv2-only', 'disabled'], Boolean] $ntlm_auth = false,
  Variant[Undef, Integer] $machine_password_timeout = 604800,
  Variant[Undef, String] $realm = undef,
  Variant[Undef, String] $kerberos_method = 'default',
  Variant[Undef, String] $dedicated_keytab_file = undef,
  Variant[Undef, Boolean] $obey_pam_restrictions = false,
  Variant[Undef, Hash] $idmap_config = {},
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
