require 'helper'

class TestSoap < TestSetup
  def test_invalid_soap_call
    assert_raises Savon::UnknownOperationError do
      VCR.use_cassette('invalid_soap_call') do
        TaxCloud.client.request :invalid, body: {}
      end
    end
  end
end
