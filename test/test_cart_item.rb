require 'helper'

class TestCartItem < Minitest::Test
  def setup
    @cart_item = TaxCloud::CartItem.new index: 0, item_id: 'SKU-100', tic: '0000', price: 50.00, quantity: 3
  end

  def test_variables
    assert_equal 0, @cart_item.index
    assert_equal 'SKU-100', @cart_item.item_id
    assert_equal '0000', @cart_item.tic
    assert_equal 50.00, @cart_item.price
    assert_equal 3, @cart_item.quantity
  end
end
