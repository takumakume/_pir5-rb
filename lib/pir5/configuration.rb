module Pir5
  module Configuration
    attr_accessor :api_endpoint, :api_token, :ssl_verify

    def configure
      yield self
    end

    def defaults
      @api_endpoint = ENV['PIR5_API_ENDPOINT'] || 'https://localhost:8080/'
      @api_token = ENV['PIR5_API_TOKEN'] || 'test'
      @ssl_verify = ENV['SSL_VERIFY'].to_i || 1
    end
  end
end
