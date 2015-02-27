class drush::git::drush (
  $git_branch = '',
  $git_tag    = '',
  $git_repo   = 'https://github.com/drush-ops/drush.git',
  $update     = false
  ) inherits drush::defaults {

  include drush::apt::update

  Exec { path    => ['/bin', '/usr/bin', '/usr/local/bin', '/usr/share'], }

  if !defined(Package['git']) and !defined(Package['git-core']) {
    package { 'git':
      ensure => present,
      require => Exec['drush_update_apt'],
    }
  }

  if !defined(Package['php5-cli']) {
    package { 'php5-cli':
      ensure => present,
      require => Exec['drush_update_apt'],
    }
  }

  if !defined(Package['curl']) {
    package { 'curl':
      ensure => present,
      require => Exec['drush_update_apt'],
    }
  }

  drush::git { $git_repo :
    path       => '/usr/share',
    git_branch => $git_branch,
    git_tag    => $git_tag,
    update     => $update,
    require    => Package['git'],
  } ->
  composer::exec { 'drush':
    cmd     => 'install',
    cwd     => '/usr/share/drush',
    require => Drush::Git[$git_repo],
  } ->
  file { 'symlink drush':
    ensure => link,
    path   => '/usr/bin/drush',
    target => '/usr/share/drush/drush',
  } ->
  exec { 'first drush run':
    command => 'drush cache-clear drush',
    path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/usr/share/drush/drush' ],
  }
}
