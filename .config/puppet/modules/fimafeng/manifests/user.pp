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

  file {
    "${home}/.profile":
    source => ["/vagrant/.config/files/.profile",
      "puppet:///modules/fimafeng/profile"];
    "${home}/.bashrc":
      source => ["/vagrant/.config/files/.bashrc",
        "puppet:///modules/fimafeng/bashrc"];
    "${home}/.bash_aliases":
      source => ["/vagrant/.config/files/.bash_aliases",
        "puppet:///modules/fimafeng/bash_aliases"];
    "${home}/.vimrc":
      source => ["/vagrant/.config/files/.vimrc",
        "puppet:///modules/fimafeng/vimrc"];
  }
}