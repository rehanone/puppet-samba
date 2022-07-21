# samba::config
#
class samba::config () inherits samba {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  augeas { 'samba-global-section':
    incl    => $samba::incl,
    lens    => lookup('samba::config_lens'),
    changes => "set ${samba::target} global",
    notify  => Class["${module_name}::service"],
  }

  samba::option {
    'workgroup':                value => $samba::workgroup;
    'server string':            value => $samba::server_string;
    'netbios name':             value => $samba::netbios_name;
    'domain master':            value => $samba::domain_master;
    'preferred master':         value => $samba::preferred_master;
    'local master':             value => $samba::local_master;
    'os level':                 value => $samba::os_level;
    'wins support':             value => $samba::wins_support;
    'wins server':              value => $samba::wins_server;
    'name resolve order':       value => $samba::name_resolve_order;
    'server min protocol':      value => $samba::server_min_protocol;
    'client max protocol':      value => $samba::client_max_protocol;
    'client min protocol':      value => $samba::client_min_protocol;
    'hosts allow':              value => $samba::hosts_allow;
    'hosts deny':               value => $samba::hosts_deny;
    'interfaces':               value => $samba::interfaces;
    'bind interfaces only':     value => $samba::bind_interfaces_only;
    'security':                 value => $samba::security;
    'encrypt passwords':        value => $samba::encrypt_passwords;
    'unix password sync':       value => $samba::unix_password_sync;
    'socket options':           value => $samba::socket_options;
    'map to guest':             value => $samba::map_to_guest;
    'passdb backend':           value => $samba::passdb_backend;
    'log file':                 value => $samba::log_file;
    'max log size':             value => $samba::max_log_size;
    'syslog':                   value => $samba::syslog;
    'ntlm auth':                value => $samba::ntlm_auth;
    'machine password timeout': value => $samba::machine_password_timeout;
  }

  create_resources('samba::share', $samba::shares)
}
