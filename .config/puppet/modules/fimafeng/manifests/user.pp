define fimafeng::user (
  $home,
) {
  User { ensure => present,
    groups => 'sudo',
    shell  => '/bin/bash',
  }

# Various dotfiles
  File { ensure  => present,
    owner   => $name,
    group   => $name,
    replace => false,
  }

  if !defined(File[$home]) {
    file { $home:
      ensure => directory,
    }
  }
}