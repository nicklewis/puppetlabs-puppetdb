Puppet::Type.newtype(:puppetdb_conn_validator) do

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end

  newparam(:puppetdb_server) do
    desc 'The DNS name or IP address of the server where puppetdb should be running.'
  end

  newparam(:puppetdb_port) do
    desc 'The port that the puppetdb server should be listening on.'
  end

  #newparam(:value) do
  #  desc 'The value of the setting to be defined.'
  #end
  #
  #newparam(:path) do
  #  desc 'The ini file Puppet will ensure contains the specified setting.'
  #  validate do |value|
  #    unless (Puppet.features.posix? and value =~ /^\//) or (Puppet.features.microsoft_windows? and (value =~ /^.:\// or value =~ /^\/\/[^\/]+\/[^\/]+/))
  #      raise(Puppet::Error, "File paths must be fully qualified, not '#{value}'")
  #    end
  #  end
  #end

end
