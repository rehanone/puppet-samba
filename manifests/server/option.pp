# == Define samba::server::option
#
define samba::server::option (
  Variant[Boolean, Integer, String, Array[String], Undef] $value = undef,
  String $config_file = $samba::params::config_file,
  String $lens        = 'Samba.lns',
  String $target      = $samba::server::target,
) {
  $str_value = $value ? {
    Array   => join($value, ' '),
    true    => 'yes',
    false   => 'no',
    undef   => '',
    default => $value
  }

  $changes = $str_value ? {
    ''      => "rm \"${target}/${name}\"",
    default => "set \"${target}/${name}\" \"${str_value}\"",
  }

  augeas { "samba-${name}":
    incl    => $config_file,
    lens    => $lens,
    changes => $changes,
    notify  => Class["${module_name}::server::service"]
  }
}
