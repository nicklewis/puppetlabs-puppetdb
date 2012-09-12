class puppetdb::params {
    # TODO: need to condition this based on whether we are a PE install or not

    # TODO: docs
    # TODO: most of these are not required for embedded db
    $ssl_listen_address    = $::fqdn
    $ssl_listen_port       = 8081

    $database          = 'postgres'
    $database_host     = 'localhost'
    $database_port     = '5432'
    $database_name     = 'puppetdb'
    $database_username = 'puppetdb'
    $database_password = 'puppetdb'
    $gc_interval       = 60
    $confdir           = '/etc/puppetdb/conf.d'
}