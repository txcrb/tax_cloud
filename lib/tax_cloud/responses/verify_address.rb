module TaxCloud #:nodoc:
  module Responses #:nodoc:

    # Response to a TaxCloud VerifyAddress API call.
    # 
    # See https://api.taxcloud.net/1.0/TaxCloud.asmx?op=VerifyAddress.
    class VerifyAddress < Base

      error_number "verify_address_response/verify_address_result/err_number"
      error_message "verify_address_response/verify_address_result/err_description"
      
      class << self
        # Parse a TaxCloud response.
        #
        # === Parameters
        # [savon_response] SOAP response.
        #
        # Returns a verified TaxCloud::Address.
        def parse(savon_response)
          response = self.new(savon_response)
          result = response.match("verify_address_response/verify_address_result")
          result.delete(:err_number)
          TaxCloud::Address.new result
        end
      end

    end
  end
end