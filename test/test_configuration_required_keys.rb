require 'helper'

class TestConfigurationRequiredKeys < Minitest::Test
  def setup
    TaxCloud.reset!
  end

  def test_missing_configuration
    assert_raises TaxCloud::Errors::MissingConfig do
      TaxCloud.client.request :dummy, body: {}
    end
  end

  def test_mising_api_login_id
    TaxCloud.configure do |config|
      config.api_key = 'taxcloud_api_key'
    end
    assert_raises TaxCloud::Errors::MissingConfigOption do
      TaxCloud.client.request :dummy, body: {}
    end
  end

  def test_mising_api_key
    TaxCloud.configure do |config|
      config.api_login_id = 'taxcloud_api_login_id'
    end
    assert_raises TaxCloud::Errors::MissingConfigOption do
      TaxCloud.client.request :dummy, body: {}
    end
  end
end
