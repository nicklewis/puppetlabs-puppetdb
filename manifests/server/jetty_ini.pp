# TODO: docs

#TODO add support for non-ssl config

class puppetdb::server::jetty_ini(
    $ssl_listen_address      = $puppetdb::params::ssl_listen_address,
    $ssl_listen_port         = $puppetdb::params::ssl_listen_port,
    $confdir                 = $puppetdb::params::confdir,
) inherits puppetdb::params {
  #Set the defaults
  Ini_setting {
      path    => "${confdir}/jetty.ini",
      ensure  => present,
      section => 'jetty',
  }

  # TODO: figure out some way to make sure that the ini_file module is installed,
  #  because otherwise these will silently fail to do anything.

  # TODO: there is a bug in ini_file where a line that doesn't have anything
  #  after the '=' sign will not match

  ini_setting {'puppetdb_sslhost':
      setting => 'ssl-host',
      value   => $ssl_listen_address,
  }
  ini_setting {'puppetdb_sslport':
      setting => 'ssl-port',
      value   => $ssl_listen_port,
  }
}
