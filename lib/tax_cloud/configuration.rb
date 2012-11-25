module TaxCloud
  class Configuration
    attr_accessor :api_login_id, :api_key, :usps_username

    def check!
      raise TaxCloud::Errors::MissingConfigOption.new('api_login_id') unless self.api_login_id && self.api_login_id.strip.length > 0
      raise TaxCloud::Errors::MissingConfigOption.new('api_key') unless self.api_key && self.api_key.strip.length > 0
    end
  end
end
