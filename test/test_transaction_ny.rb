require 'helper'

class TestTransactionNy < TestSetup
  def setup
    super
    origin = TaxCloud::Address.new address1: '888 6th Ave', city: 'New York', state: 'NY', zip5: '10001'
    destination = TaxCloud::Address.new address1: '888 6th Ave', city: 'New York', state: 'NY', zip5: '10001'
    cart_items = [TaxCloud::CartItem.new(index: 0, item_id: 'SKU-TEST', tic: TaxCloud::TaxCodes::GENERAL, quantity: 1, price: 50.00)]
    @transaction = TaxCloud::Transaction.new(customer_id: 42, cart_id: 708, order_id: rand(18_446_744_073_709_551_616), cart_items: cart_items, origin: origin, destination: destination)
  end

  def test_lookup_non_ssuta_state
    VCR.use_cassette('lookup_ny') do
      result = @transaction.lookup
      assert_instance_of TaxCloud::Responses::Lookup, result
      assert_equal '708', result.cart_id
      assert_equal 1, result.cart_items.count
      result.cart_items.first.tap do |item|
        assert_equal 0, item.cart_item_index
        assert_equal 0, item.tax_amount
      end
      assert_equal 0, result.tax_amount
    end
  end
end
