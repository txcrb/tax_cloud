module TaxCloud
  module Responses

    # Response to a generic TaxCloud API.
    class Generic < Base

      class_attribute :key

      class << self
        def response_key(key)
          self.key = key
          response_type "#{key}_response/#{key}_result/response_type"
          error_message "#{key}_response/#{key}_result/messages/response_message/message"
        end

        # Parse a TaxCloud response.
        # @return [ String ] "OK"
        def parse(savon_response)
          response = self.new(savon_response)
          response.raw["#{key}_response".to_sym]["#{key}_result".to_sym][:response_type]
        end
      end

    end
  end
end