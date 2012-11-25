require 'helper'

class TestTaxCodeGroups < TestSetup

  def test_all
    VCR.use_cassette('get_tic_groups') do
      assert TaxCloud::TaxCode::Groups.all.count > 0
    end
  end

  def test_lookup
    VCR.use_cassette('get_tic_groups') do
      tax_code_group = TaxCloud::TaxCode::Groups[TaxCloud::TaxCode::Groups::SCHOOL_RELATED_PRODUCTS]
      assert_equal TaxCloud::TaxCode::Groups::SCHOOL_RELATED_PRODUCTS, tax_code_group.group_id
      assert_equal "School Related Products", tax_code_group.description
    end
  end

  def test_lookup_tax_codes
    tax_code_group = VCR.use_cassette('get_tic_groups') do
      TaxCloud::TaxCode::Groups[TaxCloud::TaxCode::Groups::SCHOOL_RELATED_PRODUCTS]
    end
    VCR.use_cassette('get_tics_by_group') do
      assert tax_code_group.tax_codes.count > 0
      tax_code = tax_code_group[TaxCloud::TaxCodes::SCHOOL_INSTRUCTIONAL_MATERIAL]
      assert_equal TaxCloud::TaxCodes::SCHOOL_INSTRUCTIONAL_MATERIAL, tax_code.ticid
      assert_equal "School instructional material", tax_code.description
    end
  end

end
