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
      request_params = {
        'apiLoginId' => TaxCloud.configuration.api_login_id,
        'apiKey' => TaxCloud.configuration.api_key,
        'uspsUserID' => TaxCloud.configuration.usps_username
      }.merge(to_hash.downcase_keys!)
      response = TaxCloud.client.request :verify_address, :body => request_params
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
