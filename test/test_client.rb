require 'helper'

class TestClient < TestSetup
  def test_ping_with_invalid_credentials
    assert_raise TaxCloud::Errors::ApiError do
      VCR.use_cassette('ping_with_invalid_credentials') do
        TaxCloud.client.ping
      end
    end
  end

  def test_ping_with_invalid_response
    e = assert_raise TaxCloud::Errors::UnexpectedSoapResponse do
      VCR.use_cassette('ping_with_invalid_response') do
        TaxCloud.client.ping
      end
    end
    assert_equal 'Expected a value for `ping_result` in `ping_response/ping_result/response_type` in the TaxCloud response.', e.problem
  end

  def test_ping
    VCR.use_cassette('ping') do
      response = TaxCloud.client.ping
      assert_equal 'OK', response
    end
  end
end
