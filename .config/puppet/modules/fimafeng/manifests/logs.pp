class fimafeng::logs {
  file { '/var/aegir/.drush/aegir_site_logs.drush.inc':
    ensure  => present,
    owner => aegir, group => aegir,
    source => 'puppet:///modules/fimafeng/aegir_site_logs.drush.inc',
  }
}