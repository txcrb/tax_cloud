module TaxCloud #:nodoc:
  # An <tt>Address</tt> defines an address in the United States.
  class Address < Record

    # First line of address.
    attr_accessor :address1
    # Second line of adress.
    attr_accessor :address2
    # City.
    attr_accessor :city
    # State.
    attr_accessor :state
    # 5-digit Zip Code.
    attr_accessor :zip5
    # 4-digit Zip Code.
    attr_accessor :zip4

    # Verify this address.
    #
    # Returns a verified TaxCloud::Address.
    def verify
      params = to_hash.downcase_keys
      params = params.merge({ 
        'uspsUserID' => TaxCloud.configuration.usps_username 
      }) if TaxCloud.configuration.usps_username
      response = TaxCloud.client.request(:verify_address, params)
      TaxCloud::Responses::VerifyAddress.parse(response)
    end

    # Convert the object to a usable hash for SOAP requests.
    def to_hash
      {
        'Address1' => address1,
        'Address2' => address2,
        'City' => city,
        'State' => state,
        'Zip5' => zip5,
        'Zip4' => zip4
      }
    end

  end
end
