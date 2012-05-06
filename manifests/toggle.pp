define config::toggle($target, $setting=false) {

  $fragment_file = "/tmp/${target}.d/${name}"

  file { $fragment_file:
    ensure  => present,
    content => template('config/toggle.yml.erb'),
    notify  => Exec['rebuild-conf'],
  }
}
