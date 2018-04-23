# == Define samba::server::option
#
define samba::server::option ( $value = '' ) {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $incl    = $samba::server::incl
  $context = $samba::server::context
  $target  = $samba::server::target



  if ($value =~ Array[Any]) {
    $str_value = join($value, " ")
  } else {
    $str_value = $value
  }

  $changes = $str_value ? {
    ''      => "rm ${target}/${name}",
    default => "set \"${target}/${name}\" \"${str_value}\"",
  }

  augeas { "samba-${name}":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $changes,
    require => Augeas['samba-global-section'],
    notify  => Class["${module_name}::server::service"]
  }
}
