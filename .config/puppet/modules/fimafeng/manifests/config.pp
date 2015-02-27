class fimafeng::config {
  exec { "enable-task-queue":
    command => "drush @hostmaster vset hosting_queue_tasks_enabled '1'",
    user => "aegir",
    path => ['/bin', '/usr/bin'],
    environment => 'HOME=/var/aegir',
  }
  exec { "set-platform-pathauto":
    command => "drush @hostmaster vset hosting_platform_pathauto_base_path '/var/aegir/shared_platforms/'",
    user => "aegir",
    path => ['/bin', '/usr/bin'],
    environment => 'HOME=/var/aegir',
  }
  exec { "allow-delete-before-disable":
    command => "drush @hostmaster vset hosting_require_disable_before_delete '1'",
    user => "aegir",
    path => ['/bin', '/usr/bin'],
    environment => 'HOME=/var/aegir',
  }
}