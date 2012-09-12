# TODO: docs

class puppetdb::server(
    $ssl_listen_address      = $puppetdb::params::ssl_listen_address,
    $ssl_listen_port         = $puppetdb::params::ssl_listen_port,
    $database                = $puppetdb::params::database,
    $database_host           = $puppetdb::params::database_host,
    $database_port           = $puppetdb::params::database_port,
    $database_username       = $puppetdb::params::database_username,
    $database_password       = $puppetdb::params::database_password,
    $database_name           = $puppetdb::params::database_name,
    $confdir                 = $puppetdb::params::confdir,
    $gc_interval             = $puppetdb::params::gc_interval,
    $version                 = 'present',
) inherits puppetdb::params {

    package { 'puppetdb':
        ensure  => present,
        notify => Service['puppetdb'],
    }

    class { 'puppetdb::server::database_ini':
        database                => $database,
        database_host           => $database_host,
        database_port           => $database_port,
        database_username       => $database_username,
        database_password       => $database_password,
        database_name           => $database_name,
        confdir                 => $confdir,
        notify                  => Service['puppetdb'],
    }

    class { 'puppetdb::server::jetty_ini':
        ssl_listen_address  => $ssl_listen_address,
        ssl_listen_port     => $ssl_listen_port,
        confdir             => $confdir,
        notify              => Service['puppetdb'],
    }

    service { 'puppetdb':
        ensure => running,
        enable => true,
    }

    Package['puppetdb'] ->
        Class['puppetdb::server::database_ini'] ->
        Class['puppetdb::server::jetty_ini'] ->
        Service['puppetdb']
    
}