node default {
  notify { 'enduser-before': }
  notify { 'enduser-after': }

  user { 'vagrant': }
  user { 'root': }

  class { 'samba':
    require           => Notify['enduser-before'],
    before            => Notify['enduser-after'],
  }
}
