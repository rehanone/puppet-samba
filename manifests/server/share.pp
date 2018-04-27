# == Define samba::server::share
#
define samba::server::share(
  String            $comment,
  Stdlib::Absolutepath
                    $path,
  Optional[Boolean] $writable = undef,
  Optional[Boolean] $available = undef,
  Optional[Boolean] $browseable = undef,
  Optional[String]  $copy = undef,
  Optional[String]  $create_mask = undef,
  Optional[String]  $directory_mask = undef,
  Optional[String]  $force_group = undef,
  Optional[String]  $force_user = undef,
  Optional[String]  $guest_account = undef,
  Optional[Boolean] $guest_ok = undef,
  Optional[Boolean] $guest_only = undef,
  Optional[Boolean] $hide_unreadable = undef,
  Optional[Boolean] $read_only = undef,
  Optional[Boolean] $public = undef,
  Optional[Boolean] $printable = undef,
  Optional[Array[String]]
                    $valid_users = undef,
  Optional[Boolean] $follow_symlinks = undef,
  Optional[Boolean] $wide_links = undef,
  Optional[Boolean] $map_acl_inherit = undef,
  Optional[Boolean] $store_dos_attributes = undef,
  Optional[Boolean] $strict_allocate = undef,
  Optional[String]  $oplocks = undef,
  Optional[String]  $level2_oplocks = undef,
  Optional[String]  $veto_oplock_files = undef,
  Optional[String]  $write_list = undef,
  Enum[present, absent]
                    $ensure = present,
) {

  $incl    = $samba::server::incl
  $context = $samba::server::context
  $target  = "target[. = '${name}']"

  augeas { "${title}-section":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm ${target} '${name}'",
    },
    notify  => Class['samba::server::service']
  }

  if $ensure == 'present' {

    samba::server::option {
      "${title}-comment":              target => $target, key => 'comment',  value => $comment;
      "${title}-path":                 target => $target, key => 'path',     value => $path;
      "${title}-writable":             target => $target, key => 'writable', value => $writable;
      "${title}-available":            target => $target, key => 'available', value => $available;
      "${title}-browseable":           target => $target, key => 'browseable', value => $browseable;
      "${title}-copy":                 target => $target, key => 'copy', value => $copy;
      "${title}-create mask":          target => $target, key => 'create mask', value => $create_mask;
      "${title}-directory mask":       target => $target, key => 'directory mask', value => $directory_mask;
      "${title}-force group":          target => $target, key => 'force group', value => $force_group;
      "${title}-force user":           target => $target, key => 'force user', value => $force_user;
      "${title}-guest account":        target => $target, key => 'guest account', value => $guest_account;
      "${title}-guest ok":             target => $target, key => 'guest ok', value => $guest_ok;
      "${title}-guest only":           target => $target, key => 'guest only', value => $guest_only;
      "${title}-hide unreadable":      target => $target, key => 'hide unreadable', value => $hide_unreadable;
      "${title}-read only":            target => $target, key => 'read only', value => $read_only;
      "${title}-public":               target => $target, key => 'public', value => $public;
      "${title}-printable":            target => $target, key => 'printable', value => $printable;
      "${title}-follow symlinks":      target => $target, key => 'follow symlinks', value => $follow_symlinks;
      "${title}-wide links":           target => $target, key => 'wide links', value => $wide_links;
      "${title}-map acl inherit":      target => $target, key => 'map acl inherit', value => $map_acl_inherit;
      "${title}-store dos attributes": target => $target, key => 'store dos attributes', value => $store_dos_attributes;
      "${title}-strict allocate":      target => $target, key => 'strict allocate', value => $strict_allocate;
      "${title}-valid users":          target => $target, key => 'valid users', value => $valid_users;
      "${title}-oplocks":              target => $target, key => 'oplocks', value => $oplocks;
      "${title}-level2 oplocks":       target => $target, key => 'level2 oplocks', value => $level2_oplocks;
      "${title}-veto oplock files":    target => $target, key => 'veto oplock files', value => $veto_oplock_files;
      "${title}-write list":           target => $target, key => 'write list', value => $write_list;
    }
  }
}
