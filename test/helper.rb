require 'test/unit'
require 'tax_cloud'
require 'json'

Savon.configure do |config|
  config.log = false
end

HTTPI.log = false

require 'vcr_setup'
require 'test_setup'
