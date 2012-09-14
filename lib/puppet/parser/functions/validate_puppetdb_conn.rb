require 'puppet/network/http_pool'

module Puppet::Parser::Functions
  newfunction(:validate_puppetdb_conn, :type => :rvalue) do |args|
    begin
      host, port = args
      #TODO splain
      path = "/metrics/mbean/java.lang:type=Memory"
      headers = { "Accept" => "application/json" }
      conn = Puppet::Network::HttpPool.http_instance(host, port, true)
      response = conn.get(path, headers)
      unless response.kind_of?(Net::HTTPSuccess)
        Puppet.err "Unable to connect to puppetdb server (#{host}:#{port}): [#{response.code}] #{response.msg}"
        return false
      end
      true
    rescue => e
      Puppet.err "Unable to connect to puppetdb server (#{host}:#{port})"
      raise e
    end
  end
end
