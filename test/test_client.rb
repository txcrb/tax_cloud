require 'helper'

class TestClient < TestSetup

  def test_ping_with_invalid_credentials
    assert_raise TaxCloud::Errors::UnexpectedSoapResponse do
      VCR.use_cassette('ping_with_invalid_credentials') do
        TaxCloud.client.ping
      end
    end
  end

  def test_ping_with_invalid_response
    assert_raise TaxCloud::Errors::UnexpectedSoapResponse do
      VCR.use_cassette('ping_with_invalid_response') do
        TaxCloud.client.ping
      end
    end
  end

  def test_ping
    VCR.use_cassette('ping') do
      response = TaxCloud.client.ping
      assert_instance_of TaxCloud::Responses::Ping, response
    end
  end

end
