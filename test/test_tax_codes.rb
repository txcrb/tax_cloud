require 'helper'

class TestTaxCode < TestSetup

  def test_all
    VCR.use_cassette('get_tics') do
      assert TaxCloud::TaxCodes.all.count > 0
    end
  end

  def test_lookup
    VCR.use_cassette('get_tics') do
      tic = TaxCloud::TaxCodes[TaxCloud::TaxCodes::HANDLING_FEE]
      assert_equal TaxCloud::TaxCodes::HANDLING_FEE, tic.ticid
      assert_equal "Handling, crating, packing, preparation for mailing or delivery, and similar charges", tic.description
    end
  end

end
