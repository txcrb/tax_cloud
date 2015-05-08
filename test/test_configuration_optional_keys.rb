require 'helper'

describe 'TaxCloud::Configuration' do
  def request
    TaxCloud.client.instance_variable_get('@wsdl').request
  end

  def reset_and_configure(options = {})
    TaxCloud.reset!
    TaxCloud.configure do |config|
      config.api_key = 'stubbed_api_key'
      config.api_login_id = 'stubbed_api_login_id'
      options.each do |key, value|
        config.public_send("#{key}=", value)
      end
    end
  end

  describe 'open_timeout option' do
    it 'has set default to 2' do
      reset_and_configure
      assert_equal 2, request.open_timeout
    end

    it 'can be changed via configuration' do
      reset_and_configure(open_timeout: 3)
      assert_equal 3, request.open_timeout
    end
  end

  describe 'read_timeout option' do
    it 'has set default to 2' do
      reset_and_configure
      assert_equal 2, request.read_timeout
    end

    it 'can be changed via configuration' do
      reset_and_configure(read_timeout: 3)
      assert_equal 3, request.read_timeout
    end
  end
end
