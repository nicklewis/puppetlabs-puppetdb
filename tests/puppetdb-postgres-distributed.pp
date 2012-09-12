node puppet {
    class { 'puppetdb::terminus':
        puppetdb_server => 'puppetdb',
    }
}

node puppetdb-postgres {
    include puppetdb::postgresql::server
}

node puppetdb {
    class { 'puppetdb::server':
        ssl_listen_address => 'puppetdb',
        database_host      => 'puppetdb-postgres',
    }
}
