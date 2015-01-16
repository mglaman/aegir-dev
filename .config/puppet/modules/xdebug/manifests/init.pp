class xdebug {

  notice("Provisioning xdebug")
  if ! defined(Package['xdebug']) {
    package { 'xdebug':
      name    => 'php5-xdebug',
      ensure  => 'installed',
    }
  }
}
