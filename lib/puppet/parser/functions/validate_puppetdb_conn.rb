#require 'puppet/util/logging'
require 'puppet/network/http_pool'

module Puppet::Parser::Functions
  newfunction(:validate_puppetdb_conn, :type => :rvalue) do |args|
    begin
      host, port = args
      puts "Hi there"
      #Puppet.notice("HI from logging!!!")

      path = "/metrics/mbean/java.lang:type=Memory"
      headers = { "Accept" => "application/json" }
      #Puppet.notice("HI from logging2!!!")
      conn = Puppet::Network::HttpPool.http_instance(host, port, true)
      #Puppet.notice("HI from logging3!!!")
        response = conn.get(path, headers)
      #Puppet.notice("HI from logging4!!!")
      unless response.kind_of?(Net::HTTPSuccess)
        #Puppet.notice("HI from logging5!!!")
        Puppet.err "Unable to connect to puppetdb server (#{host}:#{port}): [#{response.code}] #{response.msg}"
        return false
      end
      #Puppet.notice("HI from logging6!!!")
      true
    rescue => e
      Puppet.err "Unable to connect to puppetdb server (#{host}:#{port})"
      raise e
    end
  end
end
