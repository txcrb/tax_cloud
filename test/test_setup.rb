class TestSetup < Test::Unit::TestCase
  def setup
    TaxCloud.configure do |config|
      config.api_login_id = 'taxcloud_api_login_id'
      config.api_key = 'taxcloud_api_key'
      config.usps_username = 'usps_username'
    end
  end

  def teardown
    TaxCloud.reset!
  end
end
