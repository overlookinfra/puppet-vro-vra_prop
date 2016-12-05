module Puppet::Parser::Functions
  newfunction(:vra_prop, :type => :rvalue) do |arg|
    answer = nil
    response = []
    key = arg[0]
    certname = lookupvar('clientcert')
    command = %{curl -s -X GET 'http://localhost:8080/pdb/query/v4/fact-contents' \
      --data-urlencode 'query=["and", ["=", "certname", "#{certname}"], \
                                      ["=", "path", [ "puppet_vra_properties", "Puppet.VRA.Prop.#{key}"]]]'}
    begin
      response = JSON.parse(%x(#{command}))
    rescue JSON::ParserError => e
    end
    answer = response[0]["value"] unless response.empty?
    answer
  end
end
