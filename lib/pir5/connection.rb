require 'faraday'
require 'faraday_middleware'
require 'pir5/errors'

module Pir5
  module Connection
    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def last_response
      @last_response if defined? @last_response
    end

    def request(method, url = nil, data = nil, headers = nil, &block)
      @last_response = if %i(post put patch).include?(method)
          connection.run_request(method, url, data, headers, &block)
        else
          connection.run_request(method, url, nil, headers) { |r|
            r.params.update(data) if data
            yield(r) if block_given?
          }
        end

      if error = Error.from_response(@last_response)
        raise error
      end

      @last_response.body
    end

    private

    def connection
      user_agent = "pir5/#{VERSION} (+https://github.com/pir5/pir5-rb; ruby#{RUBY_VERSION})"

      params = {
        url: @api_endpoint,
        ssl: { verify: @ssl_verify },
        headers: {
          user_agent: user_agent,
          content_type: 'application/json'
        }
      }

      @connection ||= Faraday.new(params) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.adapter Faraday.default_adapter
      end

      @connection.authorization(:Bearer, @api_token) if @connection && !!@api_token
      @connection
    end
  end
end
