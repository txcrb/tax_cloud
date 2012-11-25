require 'helper'

class TestTaxCode < TestSetup

  def test_all
    VCR.use_cassette('get_tics') do
      assert TaxCloud::TaxCodes.all.count > 0
    end
  end

  def test_lookup
    VCR.use_cassette('get_tics') do
      tax_code = TaxCloud::TaxCodes[TaxCloud::TaxCodes::DIRECT_MAIL_RELATED]
      assert_equal TaxCloud::TaxCodes::DIRECT_MAIL_RELATED, tax_code.ticid
      assert_equal "Direct-mail related", tax_code.description
    end
  end

end
