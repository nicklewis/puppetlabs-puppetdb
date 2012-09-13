# Class: puppetdb::terminus
#
# This class installs and configures the puppetdb terminus package, and
# configures the puppet master to use it accordingly.
#
# Parameters:
#   ['puppetdb_server'] - The dns name or ip of the puppetdb server (defaults to localhost)
#   ['puppetdb_port']   - The port that the puppetdb server is running on (defaults to 8081)
#   ['manage_routes']   - If true, the module will overwrite the puppet master's routes
#                         file to configure it to use puppetdb (defaults to true)
#   ['manage_storeconfigs'] - If true, the module will manage the puppet master's
#                         storeconfig settings (defaults to true)
#   ['puppet_confdir']  - Puppet's config directory; defaults to /etc/puppet
#   ['puppet_conf']     - Puppet's config file; defaults to /etc/puppet/puppet.conf
#
# Actions:
# - Configures the puppetdb terminus package and corresponding settings on
#   the puppet master.
#
# Requires:
# - Inifile
#
# Sample Usage:
#   class { 'puppet::terminus':
#       puppetdb_server          => 'localhost'
#       puppetdb_port            => 8081,
#   }
#

# TODO: port this to use params

class puppetdb::terminus(
      $puppetdb_server      = 'localhost',
      $puppetdb_port        = 8081,
      $manage_routes        = true,
      $manage_storeconfigs  = true,
      $puppet_confdir       = '/etc/puppet',
      $puppet_conf          = '/etc/puppet/puppet.conf',
)
{
  package { 'puppetdb-terminus':
    ensure  => present,
  }


  # TODO: we are going to have to add tests here, because if the files below
  #  are modified before the service is actually operational, then the
  #  master will be totally hosed.

  class { 'puppetdb::terminus::validate_puppetdb':
      puppetdb_server      => $puppetdb_server,
      puppetdb_port        => $puppetdb_port,
      require              => Package['puppetdb-terminus'],
  }

  if ($manage_routes) {
    class { 'puppetdb::terminus::routes':
      puppet_confdir => $puppet_confdir,
      require        => Class['puppetdb::terminus::validate_puppetdb'],
    }
  }

  if ($manage_storeconfigs) {
    class { 'puppetdb::terminus::storeconfigs':
      puppet_conf => $puppet_conf,
      require        => Class['puppetdb::terminus::validate_puppetdb'],
    }
  }

  class { 'puppetdb::terminus::puppetdb_conf':
    server         => $puppetdb_server,
    port           => $puppetdb_port,
    puppet_confdir => $puppet_confdir,
    require        => Class['puppetdb::terminus::validate_puppetdb'],
  }

}
