require 'pir5/connection'
require 'pir5/configuration'
require 'pir5/client/domains'

module Pir5
  class Client
    include Pir5::Configuration
    include Pir5::Connection
    include Pir5::Client::Domains

    def initialize(config = {})
      defaults

      config.each do |k,v|
        instance_variable_set(:"@#{key}", v)
      end
    end
  end
end
