# Class: puppetdb::terminus::storeconfigs
#
# This class configures the puppet master to enable storeconfigs and to
# use puppetdb as the storeconfigs backend.
#
# Parameters:
#   ['puppet_conf']  - The puppet config file (defaults to /etc/puppet/puppet.conf)
#
# Actions:
# - Configures the puppet master to use puppetdb for stored configs
#
# Requires:
# - Inifile
#
# Sample Usage:
#   class { 'puppetdb::terminus::storeconfigs':
#       puppet_conf => '/etc/puppet/puppet.conf'
#   }
#

# TODO: port this to use params

class puppetdb::terminus::storeconfigs(
    $puppet_conf = '/etc/puppet/puppet.conf',
)
{

  Ini_setting{
    section => 'master',
    path    => $puppet_conf,
    ensure  => present,
  }

  ini_setting {'puppetmasterstoreconfig':
    setting => 'storeconfigs',
    value   => true,
  }

  ini_setting {'puppetmasterstorebackend':
    setting => 'storeconfigs_backend',
    value   => 'puppetdb',
  }
}
