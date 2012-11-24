require 'helper'

class TestSoap < TestSetup

  def setup
    super
  end

  def test_invalid_soap_call
    assert_raise TaxCloud::Errors::SoapError do
      VCR.use_cassette('invalid_soap_call') do
        TaxCloud.client.request :invalid, :body => {}
      end
    end
  end

end
