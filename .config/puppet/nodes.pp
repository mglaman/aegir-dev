node "contrib.dev" {

  class { 'aegir::dev' :
    hostmaster_ref  => '7.x-3.x',
    provision_ref   => '7.x-3.x',
    #hostmaster_repo => 'http://git.drupal.org/project/hostmaster.git',
    #provision_repo  => 'http://git.drupal.org/project/provision.git',
    #frontend_url    => 'aegir.local',
    #db_host         => 'localhost',
    #db_user         => 'root',
    #db_password     => 'pwd',
    #admin_email     => 'test@ergonlogic.com',
    #admin_name      => 'aegir_admin',
    #makefile        => '/vagrant/makefiles/aegir-dev.make',
    #aegir_user      => 'aegir',
    #aegir_root      => '/var/aegir',
    #web_group       => 'www-data',
    #db_server       => 'mysql',
    #web_server      => 'nginx',
    #update          => true,
    platform_path   => '/var/aegir/hostmaster-7.x-3.x',
  }

  include drush_vagrant::users
  drush_vagrant::user { 'aegir':
    home_dir => '/var/aegir',
    require  => Class['aegir::dev'],
    notify   => [ Exec['chsh aegir -s /bin/bash'], Exec['/usr/sbin/adduser aegir vagrant'] ],
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

  class { 'aegir_config':
    require => Class['aegir::dev']
  }

  class { 'aegir_logs':
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
