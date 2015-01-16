class php_config {
  $ini_filename = '50-custom.ini'
  $target_dir  = '/etc/php5/mods-available'
  $target_file = "${target_dir}/${ini_filename}"

  if ! defined(File[$target_file]) {
    file { $target_file:
      ensure  => present,
      mode => 440, owner => root, group => root,
      source => 'puppet:///modules/php_config/custom.ini',
    }
  }

  $symlink = "/etc/php5/conf.d/${ini_filename}"

  if ! defined(File[$symlink]) {
    file { $symlink:
      ensure  => link,
      target  => $target_file,
    }
  }
}
