# == Define samba::option
#
# @param key
# TODO
# @param value
# TODO
# @param config_file
# TODO
# @param lens
# TODO
# @param target
# TODO

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
