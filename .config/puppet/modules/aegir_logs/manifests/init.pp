class aegir_logs {
  file { '/var/aegir/.drush/aegir_site_logs.drush.inc':
    ensure  => present,
    owner => aegir, group => aegir,
    source => 'puppet:///modules/aegir_logs/aegir_site_logs.drush.inc',
  }
}
