# TODO: docs

# TODO: port this to use params

class puppetdb::terminus::validate_puppetdb(
      $puppetdb_server      = 'localhost',
      $puppetdb_port        = 8081,
)
{
    if (validate_puppetdb_conn($puppetdb_server, $puppetdb_port) != true) {
        fail "Unable to connect to puppetdb server!"
    }
}
