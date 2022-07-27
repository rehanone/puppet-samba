node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  user { 'vagrant': }
  user { 'root': }

  class { 'samba':
    package_selection => {
      server => {
        ensure => present,
      },
      client => {
        ensure => absent,
      },
    },
    require      => Notify['enduser-before'],
    before       => Notify['enduser-after'],
  }
}
