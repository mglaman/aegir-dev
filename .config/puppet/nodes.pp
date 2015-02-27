node "aegir.dev" {
  if $yaml == undef {
    $yaml = loadyaml('/vagrant/config.yml')
  }
  if $aegir_vars == undef {
    $aegir_vars = $yaml['aegir']
  }

  include apt
  include git
  include composer

  # Install drush
  class { 'drush::git::drush' :
    git_branch => '7.0.0-alpha8',
  }

  class { 'aegir::dev' :
    hostmaster_ref  => $aegir_vars['hostmaster']['ref'],
    provision_ref   => $aegir_vars['provision']['ref'],
    hostmaster_repo => $aegir_vars['hostmaster']['url'],
    provision_repo  => $aegir_vars['provision']['url'],
    #frontend_url    => 'aegir.local',
    #db_host         => 'localhost',
    #db_user         => 'root',
    #db_password     => 'pwd',
    #admin_email     => 'test@ergonlogic.com',
    #admin_name      => 'aegir_admin',
    makefile         => $aegir_vars['makefile'],
    #aegir_user      => 'aegir',
    #aegir_root      => '/var/aegir',
    #web_group       => 'www-data',
    #db_server       => 'mysql',
    web_server      => $aegir_vars['web_server'],
    #update          => true,
    platform_path   => $aegir_vars['platform_path'],
    require => Class['drush::git::drush'],
  }

  # Define root.
  fimafeng::user { 'root':
    home => '/root',
  }

  fimafeng::user { 'aegir':
    home => '/var/aegir',
    require  => Class['aegir::dev'],
    notify   => [
      Exec['chsh aegir -s /bin/bash'],
      Exec['/usr/sbin/adduser aegir vagrant'],
    ],
  }
  exec { 'chsh aegir -s /bin/bash':
    refreshonly => true,
    path        => ['/bin', '/usr/bin']
  }

  # add aegir user to vagrant group
  exec { '/usr/sbin/adduser aegir vagrant':
    refreshonly => true,
    path        => ['/bin', '/usr/bin']
  }

  class { 'curl':
    require => Class['aegir::dev']
  }

  class { 'fimafeng::config':
    require => Class['aegir::dev']
  }

  class { 'fimafeng::logs':
    require => Class['aegir::dev']
  }

  class { 'xdebug' :
    require => Class['aegir::dev']
  }

  class { 'php_config' :
    require => Class['xdebug']
  }

  exec { "restart-apache2":
    command => "/etc/init.d/apache2 restart",
    require => Class['php_config']
  }
}
