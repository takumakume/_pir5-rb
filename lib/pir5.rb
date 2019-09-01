require 'pir5/version'
require 'pir5/client'

module Pir5
  class << self
    def client
      @client ||= Pir5::Client.new
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end
      super
    end
  end
end
