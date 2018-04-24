class samba::server::config () inherits samba::server {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  augeas { 'samba-global-section':
    incl    => $samba::server::incl,
    lens    => 'Samba.lns',
    changes => "set ${samba::server::target} global",
    notify  => Class["${module_name}::server::service"]
  }

  samba::server::option {
    'workgroup':            value => $samba::server::workgroup;
    'server string':        value => $samba::server::server_string;
    'netbios name':         value => $samba::server::netbios_name;
    'domain master':        value => $samba::server::domain_master;
    'preferred master':     value => $samba::server::preferred_master;
    'local master':         value => $samba::server::local_master;
    'os level':             value => $samba::server::os_level;
    'wins support':         value => $samba::server::wins_support;
    'wins server':          value => $samba::server::wins_server;
    'name resolve order':   value => $samba::server::name_resolve_order;
    'server min protocol':  value => $samba::server::server_min_protocol;
    'client max protocol':  value => $samba::server::client_max_protocol;
    'client min protocol':  value => $samba::server::client_min_protocol;
    'hosts allow':          value => $samba::server::hosts_allow;
    'hosts deny':           value => $samba::server::hosts_deny;
    'interfaces':           value => $samba::server::interfaces;
    'bind interfaces only': value => $samba::server::bind_interfaces_only;
    'security':             value => $samba::server::security;
    'encrypt passwords':    value => $samba::server::encrypt_passwords;
    'unix password sync':   value => $samba::server::unix_password_sync;
    'socket options':       value => $samba::server::socket_options;
    'map to guest':         value => $samba::server::map_to_guest;
    'passdb backend':       value => $samba::server::passdb_backend;
    'log file':             value => $samba::server::log_file;
    'max log size':         value => $samba::server::max_log_size;
    'syslog':               value => $samba::server::syslog;
  }

  create_resources('samba::server::share', $samba::server::shares)
}
