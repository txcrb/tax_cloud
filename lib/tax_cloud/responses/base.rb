module TaxCloud
  module Responses

    # A base TaxCloud SOAP response.
    class Base
      
      attr_accessor :raw

      class_attribute :dsl

      def initialize(savon_response)
        @raw = savon_response.to_hash
        parse!
      end

      class << self
        def response_type(value)
          self.set_dsl(:response_type, value)
        end

        def error_message(value)
          self.set_dsl(:error_message, value)
        end

        def error_number(value)
          self.set_dsl(:error_number, value)
        end

        def set_dsl(key, value)
          self.dsl ||= {}
          self.dsl[key] = value
          self.dsl
        end

        def parse(savon_response)
          self.new(savon_response)
        end
      end

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

        def parse!
          if self.dsl[:response_type]
            return true if match(self.dsl[:response_type]) == "OK"
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