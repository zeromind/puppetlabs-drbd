class drbd::package () {
  case $::os['name'] {
    'Debian': {
      $pkg = 'drbd8-utils'
    }
    'CentOS', 'RedHat': {
      case $::os['release']['major'] {
        default: {
          notify { "We are on an unsupported version of ${::os['name']}: ${::os['release']['major']}": }
        }
        '5', '6', '7': {
          include drbd::yumrepo
          $pkg = 'drbd84-utils'
          package { 'drbd kernel module':
            ensure => $drbd::package_ensure,
            name   => 'kmod-drbd84',
            before => [ Service['drbd'], Exec['modprobe drbd'] ],
          }
        }
      }
    }
  }
  if $pkg {
    package { 'drbd':
      ensure => $drbd::package_ensure,
      name   => $pkg,
    }
  }
}
