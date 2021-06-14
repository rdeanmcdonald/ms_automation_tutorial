include systemd::systemctl::daemon_reload

file { "${::installdir}/avs":
  ensure => directory,
  mode   => '0777',
  owner  => 'root',
  group  => 'root'
}
->archive { 'avs.tar.gz':
  path         => '/vagrant/avs.tar.gz',
  extract      => true,
  extract_path => "${::installdir}/avs",
  creates      => "${::installdir}/avs/publish",
  user         => 'root',
  group        => 'root'
}
->file { '/usr/lib/systemd/system':
  ensure => directory,
  mode   => '0775',
  owner  => 'root',
  group  => 'root'
}
->file { '/usr/lib/systemd/system/avs.service':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('/vagrant/avs.service.erb')
}
~>Class['systemd::systemctl::daemon_reload']
~>service { 'avs':
  ensure => 'running',
  name   => 'avs.service'
}
