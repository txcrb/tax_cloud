module TaxCloud #:nodoc:
  module Responses #:nodoc:

    # A base TaxCloud SOAP response.
    class Base

      # Raw response.      
      attr_accessor :raw

      # === Parameters
      # [savon_response] Response from a SOAP API call.
      def initialize(savon_response)
        @raw = savon_response.to_hash
        parse!
      end

      class << self

        # === Parameters
        # [value] Location of the response type in the SOAP XML.
        def response_type(value)
          self.set_dsl(:response_type, value)
        end

        # === Parameters
        # [value] Location of the error message in the SOAP XML.
        def error_message(value)
          self.set_dsl(:error_message, value)
        end

        # === Parameters
        # [value] Location of the error number in the SOAP XML.
        def error_number(value)
          self.set_dsl(:error_number, value)
        end

        # Parse a SOAP response.
        #
        # === Parameters
        # [savon_response] SOAP response.
        def parse(savon_response)
          self.new(savon_response)
        end
      end

      # Match an element in the SOAP response.
      #
      # === Parameters
      # [chain] XML path to match.
      def match(chain)
        current_value = raw
        chain.split("/").each do |key|
          current_value = current_value[key.to_sym]
          next if current_value
          raise TaxCloud::Errors::UnexpectedSoapResponse.new(raw, key, chain)
        end
        current_value
      end

      private

        class_attribute :dsl

        class << self
          def set_dsl(key, value)
            self.dsl ||= {}
            self.dsl[key] = value
            self.dsl
          end
        end

        def parse!
          if self.dsl[:response_type]
            case match(self.dsl[:response_type])
            when "OK", "Informational" then
              return true
            end
          elsif self.dsl[:error_number]
            return true if match(self.dsl[:error_number]) == "0"
          end
          if self.dsl[:error_message]
            raise TaxCloud::Errors::ApiError.new(match(self.dsl[:error_message]), raw)
          end
        end

    end
  end
end