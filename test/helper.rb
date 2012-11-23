require 'test/unit'
require 'tax_cloud'
require 'json'

Savon.configure do |config|
#  config.log = false
end

require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.stub_with :webmock
  c.filter_sensitive_data('api-login-id')  { TaxCloud.configuration.api_login_id }
  c.filter_sensitive_data('api-key')       { TaxCloud.configuration.api_key }
  c.filter_sensitive_data('usps-username') { TaxCloud.configuration.usps_username }  
end

require 'test_setup'
