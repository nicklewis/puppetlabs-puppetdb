# TODO: docs

class puppetdb::server::database_ini(
    $database                = $puppetdb::params::database,
    $database_host           = $puppetdb::params::database_host,
    $database_port           = $puppetdb::params::database_port,
    $database_username       = $puppetdb::params::database_username,
    $database_password       = $puppetdb::params::database_password,
    $database_name           = $puppetdb::params::database_name,
    $confdir                 = $puppetdb::params::confdir,
) inherits puppetdb::params {
  #Set the defaults
  Ini_setting {
      path    => "${confdir}/database.ini",
      ensure  => present,
      section => 'database',
  }
  if $database == 'embedded'{
      $classname = 'org.hsqldb.jdbcDriver'
      $subprotocol = 'hsqldb'
      $subname = 'file:/usr/share/puppetdb/db/db;hsqldb.tx=mvcc;sql.syntax_pgs=true'
  } elsif $database == 'postgres' {
      $classname = 'org.postgresql.Driver'
      $subprotocol = 'postgresql'
      $subname = "//${database_host}:${database_port}/${database}"

      ##Only setup for postgres
      ini_setting {'puppetdb_psdatabase_username':
          setting => 'username',
          value   => $database_username,
      }
       ini_setting {'puppetdb_psdatabase_password':
          setting => 'password',
          value   => $database_password,
      }
  }

  ini_setting {'puppetdb_classname':
          setting => 'classname',
          value   => $classname,
  }
  ini_setting {'puppetdb_subprotocol':
          setting => 'subprotocol',
          value   => $subprotocol,
  }
  ini_setting {'puppetdb_pgs':
          setting => 'syntax_pgs',
          value   => true,
  }
  ini_setting {'puppetdb_subname':
          setting => 'subname',
          value   => $subname,
  }
  ini_setting {'puppetdb_gc_interval':
          setting => 'gc-interval',
          value   => $gc_interval ,
  }
}
