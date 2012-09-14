# TODO: docs

class puppetdb::server::simple(
    $database = $puppetdb::params::database,
) inherits puppetdb::params {
    class { 'puppetdb::server':
        database => $database,
    }

    if ($database == "postgres") {
        class { 'puppetdb::postgresql::server':
            before => Class['puppetdb::server']
        }
    }
}
