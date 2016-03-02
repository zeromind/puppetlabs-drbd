class drbd::service (
  $service_enable = $drbd::service_enable,
  $service_ensure = $drbd::service_ensure,
) {
  @service { 'drbd':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => Package['drbd'],
    restart => 'service drbd reload',
  }
}
