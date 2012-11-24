class TestSetup < Test::Unit::TestCase
  def setup
    TaxCloud.configure do |config|
      config.api_login_id = ENV['TAXCLOUD_API_LOGIN_ID'] || 'taxcloud_api_login_id'
      config.api_key = ENV['TAXCLOUD_API_KEY'] || 'taxcloud_api_key'
      config.usps_username = ENV['TAXCLOUD_USPS_USERNAME'] || 'usps_username'
    end
  end

  def teardown
    TaxCloud.reset!
  end
end
