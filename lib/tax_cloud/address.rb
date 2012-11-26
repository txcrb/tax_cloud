module TaxCloud
  # An address
  class Address < Record
    attr_accessor :address1, :address2, :city, :state, :zip5, :zip4

    # Verify the address via TaxCloud
    def verify
      params = to_hash.downcase_keys
      params = params.merge({
        'uspsUserID' => TaxCloud.configuration.usps_username
      }) if TaxCloud.configuration.usps_username
      response = TaxCloud.client.request(:verify_address, params)
      TaxCloud::Responses::VerifyAddress.parse(response)
    end

    # Compelte zip code.
    # Returns a 9-digit Zip Code, when available.
    def zip
      return nil unless zip5 && zip5.length > 0
      [ zip5, zip4 ].select { |z| z && z.length > 0 }.join("-")
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
