require 'helper'

class TestTransaction < Test::Unit::TestCase

  def setup
    super
    origin = TaxCloud::Address.new :address1 => '888 6th Ave', :city => 'New York', :state => 'NY', :zip5 => '10001'
    destination = TaxCloud::Address.new :address1 => '888 6th Ave', :city => 'New York', :state => 'NY', :zip5 => '10001'
    cart_items = []
    cart_items << TaxCloud::CartItem.new(:index => 0, :item_id => 'SKU-TEST', :tic => TaxCloud::TaxCodes::GENERAL, :quantity => 1, :price => 50.00)
    cart_items << TaxCloud::CartItem.new(:index => 1, :item_id => 'SKU-TEST1', :tic => TaxCloud::TaxCodes::GENERAL, :quantity => 1, :price => 50.00)
    @transaction = TaxCloud::Transaction.new(:customer_id => rand(9999), :cart_id => rand(9999), :order_id => rand(9999), :cart_items => cart_items, :origin => origin, :destination => destination)
  end

  def test_lookup
    result = @transaction.lookup[:lookup_response][:lookup_result]
    result[:cart_items_response][:cart_item_response].each { |item| assert_not_nil item[:tax_amount] }
  end

  def test_authorized
    @transaction.lookup[:lookup_response][:lookup_result]
    result = @transaction.authorized
    assert_equal 'OK', result[:authorized_response][:authorized_result][:response_type]
  end

  def test_captured
    @transaction.lookup[:lookup_response][:lookup_result]
    @transaction.authorized
    result = @transaction.captured
    assert_equal 'OK', result[:captured_response][:captured_result][:response_type]
  end

  def test_authorized_with_capture
    @transaction.lookup[:lookup_response][:lookup_result]
    result = @transaction.authorized_with_capture
    assert_equal 'OK', result[:authorized_with_capture_response][:authorized_with_capture_result][:response_type]
  end

  def test_returned
    @transaction.lookup
    @transaction.authorized_with_capture
    result = @transaction.returned
    assert_equal 'OK', result[:returned_response][:returned_result][:response_type]
  end

end
