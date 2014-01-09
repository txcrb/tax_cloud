require 'helper'

class TestTransaction < TestSetup
  def setup
    super
    origin = TaxCloud::Address.new(address1: '162 East Avenue', address2: 'Third Floor', city: 'Norwalk', state: 'CT', zip5: '06851')
    destination = TaxCloud::Address.new(address1: '3121 West Government Way', address2: 'Suite 2B', city: 'Seattle', state: 'WA', zip5: '98199')
    cart_items = []
    cart_items << TaxCloud::CartItem.new(index: 0, item_id: 'SKU-TEST', tic: TaxCloud::TaxCodes::GENERAL, quantity: 1, price: 50.00)
    cart_items << TaxCloud::CartItem.new(index: 1, item_id: 'SKU-TEST1', tic: TaxCloud::TaxCodes::GENERAL, quantity: 1, price: 100.00)
    @transaction = TaxCloud::Transaction.new(customer_id: 42, cart_id: rand(18446744073709551616), order_id: rand(18446744073709551616), cart_items: cart_items, origin: origin, destination: destination)
  end

  def test_lookup
    VCR.use_cassette('lookup') do
      result = @transaction.lookup
      assert_instance_of TaxCloud::Responses::Lookup, result
      assert_equal 2, result.cart_items.count
      result.cart_items.first.tap do |item|
        assert_equal 0, item.cart_item_index
        assert_equal 4.75, item.tax_amount
      end
      result.cart_items.last.tap do |item|
        assert_equal 1, item.cart_item_index
        assert_equal 9.5, item.tax_amount
      end
      assert_equal 14.25, result.tax_amount
    end
  end

  def test_authorized
    VCR.use_cassette('authorized') do
      @transaction.lookup
      result = @transaction.authorized
      assert_equal 'OK', result
    end
  end

  class LocalizedDate < Date
    def to_s
      strftime '%d/%m/%Y'
    end
  end

  def test_authorized_with_localized_date
    VCR.use_cassette('authorized_with_localized_time') do
      @transaction.lookup
      result = @transaction.authorized(date_authorized: LocalizedDate.civil(2013, 2, 1))
      assert_equal 'OK', result
    end
  end

  def test_captured
    VCR.use_cassette('captured') do
      @transaction.lookup
      @transaction.authorized
      result = @transaction.captured
      assert_equal 'OK', result
    end
  end

  def test_authorized_with_capture
    VCR.use_cassette('authorized_with_capture') do
      @transaction.lookup
      result = @transaction.authorized_with_capture
      assert_equal 'OK', result
    end
  end

  def test_returned
    VCR.use_cassette('returned') do
      @transaction.lookup
      @transaction.authorized_with_capture
      result = @transaction.returned
      assert_equal 'OK', result
    end
  end
end
