require 'helper'

class TestAddress < Test::Unit::TestCase

  def setup
    super
    @address = TaxCloud::Address.new :address1 => '888 6th Ave', :city => 'New York', :state => 'New York', :zip5 => '10001'
  end

  def test_initialize
    assert_equal '888 6th Ave', @address.address1
    assert_equal nil, @address.address2
    assert_equal 'New York', @address.city
    assert_equal 'New York', @address.state
    assert_equal '10001', @address.zip5
    assert_equal nil, @address.zip4
  end

  def test_address_verify
    assert_respond_to @address, :verify
    verify = @address.verify
    assert_equal '0', verify[:verify_address_response][:verify_address_result][:err_number]
    bad_address = TaxCloud::Address.new :address1 => '10001 Test Street', :city => 'New York', :state => 'New York', :zip5 => '99999'
    verify = bad_address.verify
    assert_not_equal '0', verify[:verify_address_response][:verify_address_result][:err_number]
  end

end
