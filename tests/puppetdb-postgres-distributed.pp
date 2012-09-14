# TODO: docs

node puppet {
    class { 'puppetdb::terminus':
        puppetdb_server => 'puppetdb',
    }
}

node puppetdb-postgres {
    class { 'puppetdb::postgresql::server':
        listen_addresses => 'puppetdb-postgres',
    }
}

node puppetdb {
    class { 'puppetdb::server':
        database_host      => 'puppetdb-postgres',
    }
}
