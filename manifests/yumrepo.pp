class drbd::yumrepo (
  $yumrepo_ensure     = $drbd::yumrepo_ensure ,
  $yumrepo_url        = $drbd::yumrepo_url,
  $yumrepo_gpgkey_url = $drbd::yumrepo_gpgkey_url,
) {
  if $yumrepo_url {
    ensure_resource('yumrepo', 'elrepo-elrepo', {
      'ensure'   => $yumrepo_ensure,
      'baseurl'  => "$yumrepo_url/el\$releasever/\$basearch/",
      'enabled'  => 1,
      'gpgcheck' => 1,
      'gpgkey'   => $yumrepo_gpgkey_url,
    })
  }
  else {
    notify{ "yumrepo_url not provided, not managing the yumrepo": }
  }
}