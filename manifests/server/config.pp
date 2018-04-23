class samba::server::config () inherits samba::server {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  augeas { 'samba-global-section':
    incl    => $incl,
    lens    => 'Samba.lns',
    changes => "set ${target} global",
    notify  => Class["${module_name}::server::service"]
  }

	samba::server::option {
    'workgroup':            value => $workgroup;
    'server string':        value => $server_string;
    'netbios name':         value => $netbios_name;
    'domain master':        value => $domain_master;
    'preferred master':     value => $preferred_master;
    'local master':         value => $local_master;
    'os level':             value => $os_level;
    'wins support':         value => $wins_support;
    'wins server':          value => $wins_server;
    'name resolve order':   value => $name_resolve_order;
    'server min protocol':  value => $server_min_protocol;
    'client max protocol':  value => $client_max_protocol;
    'client min protocol':  value => $client_min_protocol;
    'hosts allow':          value => $hosts_allow;
    'hosts deny':           value => $hosts_deny;
    'interfaces':           value => $interfaces;
    'bind interfaces only': value => $bind_interfaces_only;
    'security':             value => $security;
    'encrypt passwords':    value => $encrypt_passwords;
    'unix password sync':   value => $unix_password_sync;
    'socket options':       value => $socket_options;
    'map to guest':         value => $map_to_guest;
    'passdb backend':       value => $passdb_backend;
    'log file':             value => $log_file;
    'max log size':         value => $max_log_size;
    'syslog':               value => $syslog;
	  }

  create_resources('samba::server::share', $samba::server::shares)
}
