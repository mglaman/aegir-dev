class fimafeng {
  # AEgir's servant.
  if !defined(Package['php5-curl']) {
    package { 'php5-curl':
      ensure => present,
      require => Exec['drush_update_apt'],
    }
  }
}