# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

file { 'bash_profile':
  path    => '/home/vagrant/.bash_profile',
  ensure  => file,
  source  => '/vagrant/manifests/bash_profile',
  require => Class['boundary'],
}

class { 'boundary':
  token => $api_token,
  require => Exec['update-packages'],
}

exec { 'update-packages':
  command => '/usr/bin/apt-get update -y',
}

package { 'stress':
  require => Exec['update-packages'],
}

package { 'sysstat':
  ensure => 'installed',
  require => Exec['update-packages'],
}

package { 'unzip':
  require => Exec['update-packages'],
}

package { 'git':
  require => Exec['update-packages'],
}

