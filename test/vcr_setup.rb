require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('api-login-id')  { TaxCloud.configuration.api_login_id }
  c.filter_sensitive_data('api-key')       { TaxCloud.configuration.api_key }
  c.filter_sensitive_data('usps-username') { TaxCloud.configuration.usps_username }  
end
