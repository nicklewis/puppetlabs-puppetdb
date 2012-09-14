# TODO: docs

include puppetdb::terminus
class { 'puppetdb::server::simple':
    database => 'embedded',
}
