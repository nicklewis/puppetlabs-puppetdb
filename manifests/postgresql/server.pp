# TODO: docs

class puppetdb::postgresql::server(
    $listen_addresses = $puppetdb::params::database_host,
) inherits puppetdb::params {

    class { '::postgresql::server':

      config_hash => {
          # TODO: make this stuff configurable
          'ip_mask_allow_all_users' => '0.0.0.0/0',
          'listen_addresses' => $listen_addresses,
          'manage_redhat_firewall' => true,

          #'ip_mask_deny_postgres_user' => '0.0.0.0/32',
          #'postgres_password' => 'puppet',
      },
    }

    postgresql::db{ 'puppetdb':
      user          => 'puppetdb',
      password      => 'puppetdb',
      grant         => 'all',
    }
}
