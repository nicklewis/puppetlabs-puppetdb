require 'puppet/network/http_pool'

def attempt_connection
  begin
    host = resource[:puppetdb_server]
    port = resource[:puppetdb_port]

    #TODO splain
    path = "/metrics/mbean/java.lang:type=Memory"
    headers = {"Accept" => "application/json"}
    conn = Puppet::Network::HttpPool.http_instance(host, port, true)
    response = conn.get(path, headers)
    unless response.kind_of?(Net::HTTPSuccess)
      Puppet.err "Unable to connect to puppetdb server (#{host}:#{port}): [#{response.code}] #{response.msg}"
      return false
    end
    return true
  rescue Errno::ECONNREFUSED => e
    Puppet.warning "Unable to connect to puppetdb server (#{host}:#{port}): #{e.inspect} "
    return false
  end
end

Puppet::Type.type(:puppetdb_conn_validator).provide(:puppet_https) do
  def exists?
    success = attempt_connection
    unless success
      Puppet.notice("Failed to connect to puppetdb; sleeping 10 seconds before retry")
      sleep 10
      success = attempt_connection
    end
    success
  end

  def create
    raise Puppet::Error, "Unable to connect to puppetdb server! (#{resource[:puppetdb_server]}:#{resource[:puppetdb_port]})"
  end


end
