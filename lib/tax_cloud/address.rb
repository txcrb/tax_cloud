module TaxCloud
  # An address
  class Address
    attr_accessor :address1, :address2, :city, :state, :zip5, :zip4

    # Initialize the object with the given variables
    def initialize(attrs = {})
      attrs.each do |sym, val|
        self.send "#{sym}=", val
      end
    end

    # Verify the address via TaxCloud
    def verify
      params = to_hash.downcase_keys
      params = params.merge({ 
        'uspsUserID' => TaxCloud.configuration.usps_username 
      }) if TaxCloud.configuration.usps_username
      response = TaxCloud.client.request(:verify_address, params)
      TaxCloud::Responses::VerifyAddress.parse(response)
    end

    # Convert the object to a usable hash for SOAP requests
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
