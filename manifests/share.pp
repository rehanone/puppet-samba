# == Define samba::share
#
#
#
# @param comment
#    This is a text field that is seen next to a share when a client does a queries the server, either via the network neighborhood or via net view to list what shares are available.
#
# @param path
#    This parameter specifies a directory to which the user of the service is to be given access.
#
# @param writable
#    If this parameter is true (ie: yes) then users of a service may create or modify files in the service's directory.
#
# @param available
#    This parameter lets you "turn off" a service. If available = false (ie, no), then ALL attempts to connect to the service will fail.
#
# @param browseable
#    This controls whether this share is seen in the list of available shares in a net view and in the browse list.
#
# @param copy
#    This parameter allows you to "clone" service entries. The specified service is simply duplicated under the current service's name.
#
# @param create_mask
#    This parameter is a bit-wise MASK for the UNIX modes of a file.
#
# @param directory_mask
#    This parameter is the octal modes which are used when converting DOS modes to UNIX modes when creating UNIX directories.
#
# @param force_create_mode
#    This parameter specifies a set of UNIX mode bit permissions that will always be set on a file created by Samba.
#
# @param force_directory_mode
#    This parameter specifies a set of UNIX mode bit permissions that will always be set on a directory created by Samba.
#
# @param force_group
#    This specifies a UNIX group name that will be assigned as the default primary group for all users connecting to this service.
#
# @param force_user
#    This specifies a UNIX user name that will be assigned as the default user for all users connecting to this service.
#
# @param guest_account
#    This is a username which will be used for access to services which are specified as $guest_ok (see below).
#
# @param guest_ok
#    If this parameter is true (ie: yes) for a service, then no password is required to connect to the service.
#
# @param guest_only
#    If this parameter is true (ie: yes) for a service, then only guest connections to the service are permitted
#
# @param hide_unreadable
#    This parameter prevents clients from seeing the existence of files that cannot be read.
#
# @param inherit_owner
#    The ownership of new files and directories is normally governed by effective uid of the connected user.
#
# @param inherit_permissions
#    The permissions on new files and directories are normally governed by create mask, directory mask, force create mode and force directory mode
#
# @param read_only
#    If this parameter is true (ie: yes) then users of a service may not create or modify files in the service's directory.
#
# @param public
#    If this parameter is true (ie: yes) for a service, then no password is required to connect to the service.
#
# @param printable
#    If this parameter is true (ie: yes) then clients may open, write to and submit spool files on the directory specified for the service.
#
# @param valid_users
#    This is a list of users that should be allowed to login to this service.
#
# @param follow_symlinks
#    This parameter allows the Samba administrator to stop smbd(8) from following symbolic links in a particular share.
#
# @param wide_links
#    This parameter controls whether or not links in the UNIX file system may be followed by the server
#
# @param map_acl_inherit
#    this parameter controls whether smbd(8) will attempt to map the 'protected' (don't inherit) flags of the Windows ACLs into an extended attribute called user.SAMBA_PAI (POSIX draft ACL Inheritance).
#
# @param store_dos_attributes
#    When set, DOS attributes will be stored onto an extended attribute in the UNIX filesystem, associated with the file or directory.
#
# @param strict_allocate
#    When this is set to yes the server will change from UNIX behaviour of not committing real disk storage blocks when a file is extended to the Windows behaviour of actually forcing the disk system to allocate real storage blocks when a file is created or extended to be a given size. In UNIX terminology this means that Samba will stop creating sparse files.
#
# @param oplocks
#    This boolean option tells smbd whether to issue oplocks (opportunistic locks) to file open requests on this share.
#
# @param level2_oplocks
#    This parameter controls whether Samba supports level2 (read-only) oplocks on a share.
#
# @param veto_oplock_files
#    This parameter allows the Samba administrator to selectively turn off the granting of oplocks on selected files that match a wildcarded list, similar to the wildcarded list used in the veto files parameter.
#
# @param write_list
#    This is a list of users that are given read-write access to a service.
#
# @param ensure
#    The absent/present state of the key/value parameter.
#
define samba::share (
  Optional[String]  $comment                  = undef,
  Optional[Stdlib::Absolutepath] $path        = undef,
  Optional[Boolean] $writable                 = undef,
  Optional[Boolean] $available                = undef,
  Optional[Boolean] $browseable               = undef,
  Optional[String]  $copy                     = undef,
  Optional[String]  $create_mask              = undef,
  Optional[String]  $directory_mask           = undef,
  Optional[String]  $force_create_mode        = undef,
  Optional[String]  $force_directory_mode     = undef,
  Optional[String]  $force_group              = undef,
  Optional[String]  $force_user               = undef,
  Optional[String]  $guest_account            = undef,
  Optional[Boolean] $guest_ok                 = undef,
  Optional[Boolean] $guest_only               = undef,
  Optional[Boolean] $hide_unreadable          = undef,
  Optional[Boolean] $inherit_owner            = undef,
  Optional[Boolean] $inherit_permissions      = undef,
  Optional[Boolean] $read_only                = undef,
  Optional[Boolean] $public                   = undef,
  Optional[Boolean] $printable                = undef,
  Optional[Array[String]]        $valid_users = undef,
  Optional[Boolean] $follow_symlinks          = undef,
  Optional[Boolean] $wide_links               = undef,
  Optional[Boolean] $map_acl_inherit          = undef,
  Optional[Boolean] $store_dos_attributes     = undef,
  Optional[Boolean] $strict_allocate          = undef,
  Optional[String]  $oplocks                  = undef,
  Optional[String]  $level2_oplocks           = undef,
  Optional[String]  $veto_oplock_files        = undef,
  Optional[String]  $write_list               = undef,
  Enum[present, absent]          $ensure      = present,
) {
  $incl = $samba::incl
  $context = $samba::context
  $target = "target[. = '${name}']"

  $section_header_change = $ensure ? {
    'present' => "set ${target} '${name}'",
    default   => "rm ${target} '${name}'",
  }

  augeas { "${title}-section":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $section_header_change,
    notify  => Class['samba::service'],
  }

  if $ensure == present {
    if $comment == undef {
      fail('parameter "comment" must be set')
    }
    if $path == undef {
      fail('parameter "path" must be set')
    }

    samba::option {
      "${title}-comment":              target => $target, key => 'comment',  value => $comment;
      "${title}-path":                 target => $target, key => 'path',     value => $path;
      "${title}-writable":             target => $target, key => 'writable', value => $writable;
      "${title}-available":            target => $target, key => 'available', value => $available;
      "${title}-browseable":           target => $target, key => 'browseable', value => $browseable;
      "${title}-copy":                 target => $target, key => 'copy', value => $copy;
      "${title}-create mask":          target => $target, key => 'create mask', value => $create_mask;
      "${title}-directory mask":       target => $target, key => 'directory mask', value => $directory_mask;
      "${title}-force create mode":    target => $target, key => 'force create mode', value => $force_create_mode;
      "${title}-force directory mode": target => $target, key => 'force directory mode', value => $force_directory_mode;
      "${title}-force group":          target => $target, key => 'force group', value => $force_group;
      "${title}-force user":           target => $target, key => 'force user', value => $force_user;
      "${title}-guest account":        target => $target, key => 'guest account', value => $guest_account;
      "${title}-guest ok":             target => $target, key => 'guest ok', value => $guest_ok;
      "${title}-guest only":           target => $target, key => 'guest only', value => $guest_only;
      "${title}-hide unreadable":      target => $target, key => 'hide unreadable', value => $hide_unreadable;
      "${title}-inherit owner":        target => $target, key => 'inherit owner', value => $inherit_owner;
      "${title}-inherit permissions":  target => $target, key => 'inherit permissions', value => $inherit_permissions;
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
