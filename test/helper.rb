require 'test/unit'
require 'tax_cloud'
require 'json'

class Test::Unit::TestCase
  def setup
    TaxCloud.configure do |config|
      config.api_login_id = 'taxcloud_api_login_id'
      config.api_key = 'taxcloud_api_key'
      config.usps_username = 'usps_username'
    end
  end
end

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