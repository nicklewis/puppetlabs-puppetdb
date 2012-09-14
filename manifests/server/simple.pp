# TODO: docs

class puppetdb::server::simple(
    $database = $puppetdb::params::database,
) inherits puppetdb::params {
    include puppetdb::server

    if ($database == "postgres") {
        class { 'puppetdb::postgresql::server':
            before => Class['puppetdb::server']
        }
    }
}
