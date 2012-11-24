require 'test/unit'
require 'tax_cloud'
require 'json'

Savon.configure do |config|
  config.log = false
end

require 'vcr_setup'
require 'test_setup'
