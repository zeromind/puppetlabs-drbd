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
          $pkg = 'drbd84-utils'
          include drbd::yumrepo
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
