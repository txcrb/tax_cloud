module TaxCloud #:nodoc:
  module Responses #:nodoc:

    # A generic response to a TaxCloud API call.
    class Generic < Base

      # Response key.
      class_attribute :key

      class << self

        # Set the response key.
        # === Parameters
        # [key] Response key.
        def response_key(key)
          self.key = key
          response_type "#{key}_response/#{key}_result/response_type"
          error_message "#{key}_response/#{key}_result/messages/response_message/message"
        end

        # Parse a TaxCloud response.
        #
        # === Parameters
        # [savon_response] SOAP response.
        #
        # Usually returns "OK" or raises an error.
        def parse(savon_response)
          response = self.new(savon_response)
          response.raw["#{key}_response".to_sym]["#{key}_result".to_sym][:response_type]
        end
      end

    end
  end
end