define config($notify_on_rebuild=undef) {

  $config_file = "/etc/${name}"
  $fragment_dir = "/tmp/${name}.d/"

  File {
    owner => root,
    group => root,
    mode  => '0644',
  }

  file { $fragment_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  exec { 'rebuild-conf':
    command     => "cat ${fragment_dir}/* > ${config_file}",
    path        => ['/bin'],
    refreshonly => true,
    subscribe   => File[$fragment_dir],
    notify      => $notify_on_rebuild,
  }

  file { $config_file:
    ensure  => file,
    require => Exec['rebuild-conf'],
  }
}

