# frozen_string_literal: true

require 'helper'

class TestAddress < TestSetup
  def setup
    super
    @address = TaxCloud::Address.new address1: '888 6th Ave', city: 'New York', state: 'New York', zip5: '10001'
  end

  def test_initialize
    assert_equal '888 6th Ave', @address.address1
    assert_nil   @address.address2
    assert_equal 'New York', @address.city
    assert_equal 'New York', @address.state
    assert_equal '10001', @address.zip5
    assert_nil   @address.zip4
  end

  def test_zip
    assert_equal '10001', @address.zip
    # 9-digit zip
    @address.zip4 = '1234'
    assert_equal '10001-1234', @address.zip
    # only 4-digit zip, which is invalid
    @address.zip5 = nil
    assert_nil @address.zip
  end

  def test_address_respond_to_verify
    assert_respond_to @address, :verify
  end

  def test_verify_good_address
    VCR.use_cassette('verify good address') do
      verified = @address.verify
      assert_instance_of TaxCloud::Address, verified
      assert_equal '888 6TH AVE', verified.address1
      assert_nil   verified.address2
      assert_equal 'NEW YORK', verified.city
      assert_equal 'NY', verified.state
      assert_equal '10001', verified.zip5
      assert_equal '3502', verified.zip4
    end
  end

  def test_verify_bad_address
    e = assert_raises TaxCloud::Errors::ApiError do
      VCR.use_cassette('verify bad address') do
        bad_address = TaxCloud::Address.new address1: '10001 Test Street', city: 'New York', state: 'New York', zip5: '99999'
        bad_address.verify
      end
    end
    assert_equal e.problem, 'Invalid Zip Code.'
  end
end
