$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'vcr'

require 'pir5'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
end

Pir5.configure do |c|
  c.api_endpoint = 'http://localhost:8080'
  c.ssl_verify = false
end
