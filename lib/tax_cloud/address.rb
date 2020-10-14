# frozen_string_literal: true

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
      if TaxCloud.configuration.usps_username
        params = params.merge(
          'uspsUserID' => TaxCloud.configuration.usps_username
        )
      end
      response = TaxCloud.client.request(:verify_address, params)
      TaxCloud::Responses::VerifyAddress.parse(response)
    end

    # Complete zip code.
    # Returns a 9-digit Zip Code, when available.
    def zip
      return nil unless zip5 && !zip5.empty?

      [zip5, zip4].select { |z| z && !z.empty? }.join('-')
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
