class curl {

  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => 'installed',
    }
  }
  if ! defined(Package['php5-curl']) {
    package { 'php5-curl':
      ensure => 'installed',
    }
  }
}
