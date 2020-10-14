# frozen_string_literal: true

require 'helper'

class TestLookupResponse < TestSetup
  class MockLookup < TaxCloud::Responses::Lookup
    def initialize; end
  end

  def test_tax_amount_handles_decimal_addition_properly
    response = TestLookupResponse::MockLookup.new

    # `tax_amount`s chosen to provoke floating point arithmetic error
    mock_savon_cart_items = [
      { cart_item_index: '0', tax_amount: '0.35' },
      { cart_item_index: '1', tax_amount: '0.7' }
    ]
    response.cart_items = mock_savon_cart_items.map { |i| TaxCloud::Responses::CartItem.new(i) }

    assert_equal 1.05, response.tax_amount
  end
end
