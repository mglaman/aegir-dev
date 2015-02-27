<?php
function aegir_site_logs_provision_apache_vhost_config($uri, $data) {
  return array(
    "ErrorLog /var/aegir/logs/" . $uri . ".error.log",
    "LogLevel warn"
  );
}
