# @summary
#   Manages smb.conf options.
#
# @param key
#    This is the Samba configuration parameter to be set.
#
# @param value
#    The value of $key in the smb.conf file.
#
# @param config_file
#    The path to the Samba configuration file. eg: /etc/samba/smb.conf.
#
# @param lens
#    The Augeas lens used to manage the entries in the $config_file.
#
# @param target
#    The Augeas target for the key/value pair settings.
#
define samba::option (
  String $key         = $title,
  Variant[Boolean, Integer, String, Array[String], Undef] $value = undef,
  String $config_file = $samba::config_file,
  String $lens        = $samba::config_lens,
  String $target      = $samba::target,
) {
  $str_value = $value ? {
    Array   => join($value, ' '),
    true    => 'yes',
    false   => 'no',
    undef   => '',
    default => $value
  }

  $changes = $str_value ? {
    ''      => "rm \"${target}/${key}\"",
    default => "set \"${target}/${key}\" \"${str_value}\"",
  }

  augeas { "samba option (${title}=${str_value})":
    incl    => $config_file,
    lens    => $lens,
    changes => $changes,
    notify  => Class["${module_name}::service"],
  }
}
