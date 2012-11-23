require 'helper'

class TestConfiguration < Test::Unit::TestCase

  def setup
    TaxCloud.reset!
  end

  def test_missing_configuration
    assert_raise TaxCloud::Errors::MissingConfig do
      response = TaxCloud.client.request :dummy, :body => {}
    end
  end

  def test_mising_api_login_id
    TaxCloud.configure do |config|
      config.api_key = 'taxcloud_api_key'
    end
    assert_raise TaxCloud::Errors::MissingConfigOption do
      response = TaxCloud.client.request :dummy, :body => {}
    end
  end

  def test_mising_api_key
    TaxCloud.configure do |config|
      config.api_login_id = 'taxcloud_api_login_id'
    end
    assert_raise TaxCloud::Errors::MissingConfigOption do
      response = TaxCloud.client.request :dummy, :body => {}
    end
  end

end
